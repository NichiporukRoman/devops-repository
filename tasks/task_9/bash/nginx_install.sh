sudo yum update
sudo yum install nginx
mkdir /home/ubuntu/site

html_to_add="<html><head><title>Added Content</title></head><body><h1>Hello, World!</h1><p>This is nginx.</p></body></html>"
echo "$html_to_add" >> /home/ubuntu/site/nginx.html

wget https://cdn-icons-png.flaticon.com/512/181/181531.png
mv 181531.png site/favicon.ico
