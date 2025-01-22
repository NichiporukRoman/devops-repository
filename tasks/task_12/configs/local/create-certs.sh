mkdir -p /home/ubuntu1/self-signed
cd /home/ubuntu1/self-signed
openssl genrsa -out selfsigned.key 2048 
openssl req -x509 -new -nodes -key selfsigned.key -sha256 -days 365 \
    -out selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=n8ire.zapto.org/"
cp /etc/ssl/self-signed/selfsigned.key /home/ubuntu1/self-signed/selfsigned.key
cp /etc/ssl/self-signed/selfsigned.crt /home/ubuntu1/self-signed/selfsigned.crt 
chmod 777 /home/ubuntu1/self-signed/
chmod 777 /home/ubuntu1/self-signed/selfsigned.key
chmod 777 /home/ubuntu1/self-signed/selfsigned.crt 