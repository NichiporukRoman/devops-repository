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
    1. Через pgAdmin:

    2. Через терминал:
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
    1. 
    2. Удаление таблицы
```
DROP DATABASE jundb;
``` 
6.  Проверка того что все что мы сделали сохранилось:
    1. Через pgAdmin:
    2. Через терминал:
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

8. Удаление и востановление 
9. Проверка того что все что мы сделали сохранилось:
    1. Через pgAdmin:
    2. Через терминал:
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