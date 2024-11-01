# Task №7 AWS RDS
## To do
1. Создать инстанс для базы данных типа postgres.
2. Подключиться к ней через pgAdmin, установленный на ПК и через командную строку терминала linux (через терминальный клиент psql).
3. Cоздать postgres базу данных jundb.
4. Создать в ней таблицу под названием credit_cards_numbers.
5. Руками сделать snapshot. Удалить базу данных. Восстановить её из snapshots.
6. Проверить наличие созданной таблицы через pgAdmin и терминальный клиент psql.
7. Настроить её бэкапы через AWS Backup по расписанию (раз в час например).
8. Когда сделан автоматический backup, удалить текущий инстанс и восстановить его из бэкапа.
9. Проверить наличие созданной таблицы credit_cards_numbers через pgAdmin и терминальный клиент psql.
## Jobs
1. В AWS RDS заходим в istance и создаем новый instance с типом postgres.
2. 
Через pgAdmin:
![1](https://github.com/user-attachments/assets/98fc2324-a5ba-437d-bd22-9417084f5b65)
![2](https://github.com/user-attachments/assets/8b460c3f-61a7-42fd-a53c-2bf2080cebe0)
![3](https://github.com/user-attachments/assets/d8ad7028-a822-47ee-a4c8-fecec3e8b567)
    

Через терминал:
```
psql -h db-roman.c5iifcvfgobh.us-east-1.rds.amazonaws.com -U postgres -d postgres -p 5433
Password for user postgres: 
```
3. Создание новой базы данных:
```
postgres=> CREATE DATABASE jundb;
ERROR:  database "jundb" already exists
postgres=> \c jundb
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2), server 16.3)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
You are now connected to database "jundb" as user "postgres".
```
4. Создание новой таблицы:
```
jundb=> CREATE TABLE credit_cards_numbers (
    id SERIAL PRIMARY KEY,
    card_number VARCHAR(16) NOT NULL
);
```
5. 
Создание snapshot:

![5](https://github.com/user-attachments/assets/c4bb9811-8e3a-42a9-8346-b6b1a9b0c476)

Удаление таблицы:
    
```
DROP DATABASE jundb;
```

Востановление snapshot:
![6](https://github.com/user-attachments/assets/b0207937-ba92-4921-ab89-a7f6cad90149)

6.  Проверка того что все что мы сделали сохранилось:
Через pgAdmin:
![8](https://github.com/user-attachments/assets/fe939fb3-334b-4707-be08-f0c3b471b89f)
![9](https://github.com/user-attachments/assets/7ea8617b-3c9f-4399-b391-103398cd877b)

Через терминал:
```
roman@roman-ASUS:~$ psql -h db-roman.c5iifcvfgobh.us-east-1.rds.amazonaws.com -U postgres -d postgres -p 5432
Password for user postgres: 
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2), server 16.3)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

postgres=> \c jundb
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2), server 16.3)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
You are now connected to database "jundb" as user "postgres".
```
7. Настройка:
![10](https://github.com/user-attachments/assets/81f89386-ee3e-4dd3-b2d0-2f0396cf68af)
![11](https://github.com/user-attachments/assets/ea6f9b90-9361-42ae-b06a-3546d2fa3e96)
8. Удаление и востановление
![12](https://github.com/user-attachments/assets/1861a3d7-76eb-42c0-a58b-9adf7c62a640)
![13](https://github.com/user-attachments/assets/4df77ed7-122e-4a12-bd84-ede68b8091d9)

9. Проверка того что все что мы сделали сохранилось:
Через pgAdmin:
![15](https://github.com/user-attachments/assets/e44c64cc-21ef-4840-af16-fb03aa15a9f5)
![16](https://github.com/user-attachments/assets/76e7ad79-726d-44a4-b710-152940fe1c0b)

Через терминал:
```
roman@roman-ASUS:~$ psql -h db-roman.c5iifcvfgobh.us-east-1.rds.amazonaws.com -U postgres -d postgres -p 5432
Password for user postgres: 
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2), server 16.3)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

postgres=> \c jundb
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2), server 16.3)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
You are now connected to database "jundb" as user "postgres".
jundb=> CREATE TABLE credit_cards_numbers (
    id SERIAL PRIMARY KEY,
    card_number VARCHAR(16) NOT NULL
);
ERROR:  relation "credit_cards_numbers" already exists
jundb=> 

```
