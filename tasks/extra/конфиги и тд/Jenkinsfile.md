```
pipeline {

    agent any

    environment {

        REMOTE_HOST = "ubuntu@3.94.107.103"

        SSH_KEY = "/var/lib/jenkins/.ssh/rodionTask2Key.pem"

        DOCKER_COMPOSE_PATH = '/var/lib/jenkins/task16/docker-compose.yml'

        DOCKER_CREDENTIALS = credentials('dockerhub')

       // DOCKER_USERNAME = credentials('dockerhub-username') // Добавьте учётные данные в Jenkins (ID: dockerhub-username)

       // DOCKER_PASSWORD = credentials('dockerhub-password') // Добавьте учётные данные в Jenkins (ID: dockerhub-password)

        IMAGE_NGINX = "rodion0013/trainee:nginx"

        IMAGE_APACHE = "rodion0013/trainee:apache"

        VERSION = "${env.BUILD_NUMBER}" // Версия образа

        CERT_PATH = "/var/lib/jenkins/task16"

    }

    stages {

        stage('Login to Docker Hub') {

            steps {

                echo 'Logging in to private Docker Hub...'

                sh 'echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin'

            }

        }

        stage('Build Docker Images') {

            steps {

                echo 'Building Docker images with version...'

                sh 'docker build -t ${IMAGE_NGINX}${VERSION} ./nginx'

                sh 'docker build -t ${IMAGE_APACHE}${VERSION} ./apache'

            }

        }

        stage('Push Docker Images') {

            steps {

                echo 'Pushing Docker images to Docker Hub...'

                sh 'docker push ${IMAGE_NGINX}${VERSION}'

                sh 'docker push ${IMAGE_APACHE}${VERSION}'

            }

        }

        stage('Clean Remote Containers and Images') {

            steps {

                echo 'Cleaning up remote containers and unused images...'

                sh """

                ssh -i ${SSH_KEY} ${REMOTE_HOST} "docker system prune -af --volumes"

                """

            }

        }

        stage('Pull Updated Images') {

            steps {

                echo 'Pulling updated Docker images on the remote server...'

                sh """

                ssh -i ${SSH_KEY} ${REMOTE_HOST} "docker pull ${IMAGE_NGINX}${VERSION}"

                ssh -i ${SSH_KEY} ${REMOTE_HOST} "docker pull ${IMAGE_APACHE}${VERSION}"

                """

            }

        }
  
        stage('Transfer Certificates') {

            steps {

                echo 'Transferring certificates to the remote server...'

                sh """

                scp -i ${SSH_KEY} ${CERT_PATH}/fullchain.pem ${REMOTE_HOST}:/home/ubuntu/

                scp -i ${SSH_KEY} ${CERT_PATH}/privkey.pem ${REMOTE_HOST}:/home/ubuntu/

                """

            }

        }

        stage('Clean Locale Containers and Images') {

            steps {

                echo 'Cleaning up remote containers and unused images...'

                sh """

                docker system prune -af --volumes

                """

            }

        }

  
        stage('Run Docker Containers') {

            steps {

                echo 'Running Docker containers on the remote server...'

               /* sh """

                ssh -i ${SSH_KEY} ${REMOTE_HOST} "docker run --network net --name apache -d -p 8080:8080 ${IMAGE_APACHE}${VERSION}"

                ssh -i ${SSH_KEY} ${REMOTE_HOST} \\

                "docker run --network net --name nginx -d -p 443:443 -p 80:80 \\

                -v /home/ubuntu/fullchain.pem:/var/www/html/cert/fullchain.pem:ro \\

                -v /home/ubuntu/privkey.pem:/var/www/html/cert/privkey.pem:ro \\

                ${IMAGE_NGINX}${VERSION}"

                """ */

                sh """

                 scp -i ${SSH_KEY} ${DOCKER_COMPOSE_PATH} ${REMOTE_HOST}:

                    ssh -i ${SSH_KEY} ${REMOTE_HOST} "

                        export IMAGE_APACHE=${IMAGE_APACHE}${VERSION}

                        export IMAGE_NGINX=${IMAGE_NGINX}${VERSION}

                        docker network create custom_net || true

                        docker-compose -f docker-compose.yml down

                        docker-compose -f docker-compose.yml pull

                        docker-compose -f docker-compose.yml up -d

                    "

                """    

            }

        }

    }


    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }

    }

}
```