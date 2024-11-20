docker stop apache
docker rm apache
docker stop nginx
docker rm nginx

docker network create --driver=bridge --subnet=192.168.0.0/16 br0

docker run -d -p 81:80 --name apache --network br0 nichiporukroman/my-apache-image
docker run -d -p 443:443 --name nginx -v /etc/ssl/self-signed:/etc/nginx/certs --network br0 nichiporukroman/my-nginx-image
