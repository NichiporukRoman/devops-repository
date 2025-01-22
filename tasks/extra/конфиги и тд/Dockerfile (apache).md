```
FROM alpine:3.20

COPY ./info.php /var/www/localhost/htdocs/info.php

RUN set -x \
     apk update && \
     apk add --no-cache apache2 php$phpverx-apache2 && \
     rm -f /var/cache/apk/* && \
     addgroup -g 1000 -S apache2 && \
     adduser -S -D -H -u 1000 -h /etc/apache2/ -s /sbin/nologin -G apache2 -g apache2 apache2 && \
     mkdir -p /app /etc/apache2 /var/www /var/log/apache2 /run/apache2 && \
     chown -R apache2:apache2 /app && \
     chown -R apache2:apache2 /etc/apache2 && \
     chown -R apache2:apache2 /var/www/ && \
     chown -R apache2:apache2 /var/log/apache2 && \
     chown -R apache2:apache2 /run/apache2 && \
     sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/httpd.conf
USER apache2

CMD ["httpd", "-D", "FOREGROUND"]
```
