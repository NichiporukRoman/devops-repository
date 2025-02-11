# Task | Terraform
## To do
Поднять в aws с помощью terraform следующее: 
1. весь VPC (public и private subnet),
2. 2 servers ( bastion host and private), security groups (SG), RDS.
3. Использовать модули.
4. Разобраться как взаимодействуют между собой variables.tf и output.tf в модулях.
5. Настроить SG для доступа на 22 порт только со своего IP.
6. Использовать переменную типа object для передачи необходимых ip для подключения на порт 22 (передать ip + имя правила)
## Jobs 
Установка `Terraform` на ubuntu:
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
Установка ключей: 
```bash
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="yyyyyyyyyyyyyyyyyyyyyyyyyyyy"
export AWS_DEFAULT_REGION="zzzzzzzzz"
```

Чтобы скачать необходимые для проекта terraform файлы: в папке с проектом выполним команду:
```bash
terraform init
```

Чтобы создать план выполнения команд:
```bash
terraform plan
```

Чтобы выполнить созданный план:
```bash
terraform apply
```
1. 



gitlabUrl: https://gitlab.com/

runnerRegistrationToken: "glrt-t3_VeA5hsAMk_Egq1uCyDAE"

concurrent: 10

checkInterval: 30

rbac:
  create: true
  rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["list", "get", "watch", "create", "delete"]
    - apiGroups: [""]
      resources: ["pods/exec"]
      verbs: ["create"]
    - apiGroups: [""]
      resources: ["pods/log"]
      verbs: ["get"]
    - apiGroups: [""]
      resources: ["pods/attach"]
      verbs: ["list", "get", "create", "delete", "update"]
    - apiGroups: [""]
      resources: ["secrets"]
      verbs: ["list", "get", "create", "delete", "update"]      
    - apiGroups: [""]
      resources: ["configmaps"]
      verbs: ["list", "get", "create", "delete", "update"]     

runners:
  privileged: true
  
  config: |
    [[runners]]
      [runners.kubernetes]
        namespace = "gitlab"
        tls_verify = false
        image = "gcr.io/kaniko-project/executor:v1.23.2-debug"
        privileged = true


