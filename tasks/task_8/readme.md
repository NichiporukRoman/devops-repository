# Task №8 IAM + Python скриптинг 
## To do
1. Создать EC2 и S3 c именем mybucket. 
2. Сделать так, чтобы доступ был к S3 был через IAM роль. (команда aws s3 ls выводит список S3 buckets)  
3. Создать в IAM пользователя Petr и предоставить ему Console access. 
4. Cоздать группу just_users. Добавить пользователя в группу just_users. Дать права группе только на полный доступ к EC2. 
5. Попробовать от имени этого пользователя создать новый инстанс в любом регионе и создать vpc в любом регионе. Рассказать о результах. 
6. Написать на питоне скрипт для создания ЕС2. 
7. Далее питоном получить всю инфу о машине (IP, OS, metrics, size, type), сменить ключ от инстанса (проверить подключение по новому ключу) и потом все убить (также кодом на питоне). 
8. Сделать еще один скрипт на bash на установку aws cli. Скрипт должен сам понять какая OS. После установки разобраться с кредами и сделать профиль. Скрипт должен отрабатывать под Redhat, Ubuntu, MacOS, Windows (+ другие по желанию) 
## P.S.
1. *Не использовать AWS configure и не делаем export переменных для кредов аккаунта AWS
2. *По умолчанию OS читает ТОЛЬКО баш скрипты. Т.е. нет питона и др. языков программирования
## Jobs
1. Команды:

Создание S3:
```bash
aws s3 mb s3://mybucketroman
```
Создание EC2:
```bash
aws ec2 run-instances --image-id ami-0866a3c8686eaeeba --count 1 --instance-type t2.nano --key-name task8 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=mybucketroman}]'
```
2. Команды:

Создание IAM роли:
```bash
nano trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

aws iam create-role --role-name roman-role --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy --role-name roman-role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
``` 

Создание политики доступа:
```bash
nano bucket-policy.json
GNU nano 5.8                                                                                                                        bucket-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::mybucketroman",
        "arn:aws:s3:::mybucketroman/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalArn": "arn:aws:iam::YOUR_ACCOUNT_ID:role/roman-role"
        }
      }
    }
  ]
}
aws s3api put-bucket-policy --bucket mybucketroman --policy file://bucket-policy.json
```
3. Команды:

Создание пользователя Petr:
```bash
aws iam create-user --user-name Petr
aws iam create-login-profile --user-name Petr --password pwd
aws iam attach-user-policy --user-name Petr --policy-arn arn:aws:iam::aws:policy/AWSCloudShellFullAccess
```
4. Команды:

Создание группы just_users1:
```bash
aws iam create-group --group-name just_users1
aws iam add-user-to-group --user-name Petr --group-name just_users1
aws iam attach-group-policy --group-name just_users1 --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
```
5. Команды:

Создание EC2:
```bash
aws ec2 run-instances --image-id ami-0866a3c8686eaeeba --count 1 --instance-type t2.nano --key-name task8 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=try}]'
```
Все прошло успешно

6. Смотреть /python/create-ec2.py

7. Скрипты:
  - Смотреть /python/change-key-ec2.py
  - Смотреть /python/het-info-ec2.py
  - Смотреть /python/terminate-ec2.py
8. Смотреть /bash/script.sh