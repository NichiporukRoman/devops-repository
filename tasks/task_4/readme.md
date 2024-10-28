# Task 4
## To do
### Задача №4 Nginx proxy + upsteram + regex

1. На основе прошлой задачи создать ещё два сервера в nginx и сделать переход по /redblue так, чтобы при обновлении страницы происходило чередование красной и синей страниц. Для этого необходимо задействовать балансировку и проксирование. При выводе логов показать, куда проксировался запрос клиента.
3. Создать переход на /image1 для jpg и /image2 для png.
4. Сделать регулярное выражение для картинок: если формат jpg, то картинка будет перевёрнута с помощью nginx.

## Jobs
1. upstream -> Load balancer via Round Robin 
3. location proxypass на изображения чтобы красиво было (не надо так)
4. Вот location с регулярным выражением:
```
location /img/ {
    location ~* \.jpg$ {
        image_filter rotate 180;
        root /home/user1/site;
    }
}
```
- ~*: указывает на то, что сопоставление будет регистронезависимым
- $: Это символ, который обозначает конец строки
### Install Nginx with Image Filter Support
download Nginx source code:
```
wget http://nginx.org/download/nginx-1.20.1.tar.gz
tar -zxvf nginx-1.20.1.tar.gz
cd nginx-1.20.1
```
configure Nginx with the image filter module:
```
./configure --with-http_image_filter_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module 
```
build and install Nginx:
```
make
sudo make install
```
start nginx:
```
sudo /usr/local/nginx/sbin/nginx
```