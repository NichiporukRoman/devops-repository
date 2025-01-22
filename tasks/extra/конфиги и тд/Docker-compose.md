```
version: '3'

networks:
  network:

services:
  nginx:
    container_name: nginx
    #image: rodion0013/trainee:nginx <-- для задачи 12
    image: task15:nginx <-- для задачи 15
    build:
      context: ./nginx
      dockerfile: Dockerfile
    ports:
      - "80:80"
      - "443:443"
    #volumes:
    #  - /home/rodion0011/task12/nginx/cert/fullchain.pem:/var/www/html/cert/fullchain.pem
    #  - /home/rodion0011/task12/nginx/cert/privkey.pem:/var/www/html/cert/privkey.pem

    networks:
      - network

  #certbot:
  #  image: certbot/certbot
   # container_name: certbot
   # volumes:
    #  - ./certbot/conf:/etc/letsencrypt
    #  - ./certbot/www:/var/www/certbot
   # command: certonly --webroot -w /var/www/certbot --force-renewal --email leon172071@gmail.com -d taskr.sytes.net --agree-tos

  apache:
    container_name: apache
    #image: rodion0013/trainee:apache <-- для задачи 12
    image: task15:apache <-- для задачи 15
    build: 
      context: ./apache
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
    networks:
      - network
```
