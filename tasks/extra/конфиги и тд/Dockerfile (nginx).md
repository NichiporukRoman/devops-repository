```
FROM nginx:alpine

COPY ./html/ /var/www/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
#COPY /nginx/cert/ /var/www/html/cert/

RUN  chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid
USER nginx
CMD [ "nginx", "-g", "daemon off;"]
```
