# Task 9 Application Load Balancer 
## To do
1. Создать инстанс с nginx, который отдает вашу кастомную вебстраничку.
2. Создать инстанс с apache, который отдает вашу кастомную вебстраничку.
3. На www.noip.com (или аналог) создать несколько записей у выбранного домена следующим образом: nginx.example.com и apache.example.com *Под example.com понимается ваш домен.
4. Создать Application Load Balancer, который разводит трафик в зависимости от того на какой хост приходит запрос: 
    - если мы вводим в адресную строку браузера nginx.example.com, то попадаем на nginx с кастомной веб страничкой. 
    - если мы вводим в адресную строку браузера apache.example.com то попадаем на apache с кастомной веб страничкой. 
    - если мы вводим в адресную строку браузера google.example.com то попадаем на стартовую страницу поиска Гугл
## Jobs

1. Создать ec2 instance с Amazon linux

Устанавливаем nginx на instance:
```bash
sudo yum update
sudo yum install nginx
mkdir /home/ubuntu/site
```
В папке site создаем `nginx.html`.

Проводим настройку nginx через конфиг.

2. Создать ec2 instance с Ubuntu

Устанавливаем apache на instance:
```bash
sudo apt update
sudo apt install apache2
```
В папке /var/www/html изменяем `index.html`.

Проводим настройку apache через available-sites.

3. Создаем 3 аккаунта на [noip](https://www.noip.com/).

    Далее делаем 3 `CNAME` записи на dns load-balancer:
    - nginx.servehttp.com
    - apache2.servehttp.com
    - googlee.servehttp.com
4. Шаги:
    1. Cоздать 2 target group (nginx, apache).
    2. Создать Application Load Balancer
```
    Host header
    If Host header is nginx.servehttp.com

    Target group is nginx
```

```
    Host header
    If Host header is apache.servehttp.com

    Target group is apache
```

```
    Host header
    If Host header is googlee.servehttp.com

    redirect to link
```