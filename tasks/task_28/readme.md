# Task 28 Yandex Object store + CDN 
## To do
1. Создать публичное и приватное хранилище S3. 
2. Залить html-файл в каждое из них, проверить доступность. 
3. Собрать образ докер с nginx и поместить туда html-файл хранящийся в S3 в качестве дэфолтной страницы. 
4. Сделать это как для публичного так и приватного бакета. 
5. Cделать статик хостинг с3. 
6. Также подключить CDN.
## Jobs
1. Заходим и делаем.
```
private bucket: https://private-task-28.website.yandexcloud.net
```
```
public bucket: https://public-task-28.website.yandexcloud.net
```
2. Заливаем через Interface
3. Ниже алгоритм:
    - Забрать из хранилища html:
    ```bassh
    yc storage s3api get-object --bucket private-task-28 --key index.html ./index.html
    ``` 
    - Собираем dockerfile.
4. В пункте 3.
5. Делаем - работает только с public bucket
6. Создаем public bucket с названием **cname** **cdn** а дальше по руководству.