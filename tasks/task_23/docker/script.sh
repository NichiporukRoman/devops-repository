#!/bin/bash

# Извлекаем значение из SSM Parameter Store
parameter_value=$(aws ssm get-parameter --name "/nginx/auth" --with-decryption --query "Parameter.Value" --output text)
echo $parameter_value
# Разделяем значение на логин и пароль (предполагаем, что параметр в формате 'username:password')
username=$(echo "$parameter_value" | cut -d':' -f1)
password=$(echo "$parameter_value" | cut -d':' -f2)

# Генерируем htpasswd файл с использованием OpenSSL
hashed_password=$(openssl passwd -6 -salt $(openssl rand -hex 8) "$password")

# Создаем .htpasswd файл
echo "$username:$hashed_password" > /etc/nginx/.htpasswd

# Выводим успешное сообщение
echo "Файл .htpasswd успешно обновлен."
