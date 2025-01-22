mkdir -p /home/ubuntu1/self-signed
cd /home/ubuntu1/self-signed 
openssl genrsa -out selfsigned.key 2048 
openssl req -x509 -new -nodes -key selfsigned.key -sha256 -days 365 \
    -out selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=n8ire.zapto.org/"
