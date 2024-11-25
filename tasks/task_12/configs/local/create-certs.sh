mkdir -p /etc/ssl/self-signed
cd /etc/ssl/self-signed 
openssl genrsa -out selfsigned.key 2048 
openssl req -x509 -new -nodes -key selfsigned.key -sha256 -days 365 \
    -out selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=romand.zapto.com/"
