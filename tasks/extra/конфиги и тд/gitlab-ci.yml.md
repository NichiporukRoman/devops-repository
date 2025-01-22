```
stages:
  - build
  - deploy

include:
  - local: 'shared-config.yml'

variables:
  IMAGE_TAG: "${CI_PIPELINE_IID}"
  GIT_SUBMODULE_STRATEGY: recursive


build-job:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  parallel:
    matrix:
      - CONTEXT: "nginx"
        DOCKERFILE: "nginx/Dockerfile"
        TAG_SUFFIX: "nginx"
      - CONTEXT: "apache"
        DOCKERFILE: "apache/Dockerfile"
        TAG_SUFFIX: "apache"
  script:
    - mkdir -p /kaniko/.docker
    - >-
      /kaniko/executor
      --context "${CONTEXT}"
      --dockerfile "${CI_PROJECT_DIR}/${DOCKERFILE}"
      --destination "$ECR_REPOSITORY:${TAG_SUFFIX}-${IMAGE_TAG}"


deploy-job:
  stage: deploy
  only:
    - main
  image: registry.gitlab.com/gitlab-org/cloud-deploy/aws-base:latest
  script:
    - echo "Registering new task definition..."
    - echo $REPOSITORY_URL:$IMAGE_TAG
    - apt-get update && apt-get install -y python python3-pip
    - aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 322977037187.dkr.ecr.us-east-1.amazonaws.com
    - aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    - aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    - aws configure set default.region $AWS_DEFAULT_REGION
    - TASK_DEFINITION=$(aws ecs describe-task-definition --task-definition "$TASK_DEFINITION_NAME" --region "${AWS_DEFAULT_REGION}")
    - NEW_CONTAINER_DEFINTIION=$(echo $TASK_DEFINITION | python $CI_PROJECT_DIR/update_task_definition_image.py $ECR_REPOSITORY:nginx-$IMAGE_TAG)
    - echo "Registering new container definition..."
    - aws ecs register-task-definition --region "${AWS_DEFAULT_REGION}" --family "$TASK_DEFINITION_NAME" --container-definitions "${NEW_CONTAINER_DEFINTIION}"
    - echo "Updating the service..."
    - |
      TASKS=$(aws ecs list-tasks --cluster task17 --query 'taskArns[*]' --output text)
      if [ -z "$TASKS" ]; then
        echo "No tasks to stop."
      else
        read -a TASK_ARRAY <<< "$TASKS"
        for TASK in "${TASK_ARRAY[@]}"; do
          echo "Stopping task: $TASK"
          aws ecs stop-task --cluster task17 --task $TASK
        done
      fi
    - aws ecs run-task --cluster "${CLUSTER_NAME}" --task-definition "$TASK_DEFINITION_NAME" --launch-type EC2
```

