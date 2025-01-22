```
upstream backend_servers {
        server 127.0.0.1:8081;
        server 127.0.0.1:8082;
        }

server {
        listen 8081;
        server_name red_page;
        location / {
                return 200 '<html><body style="background-color:red;"><h1>Red Page</h1></body></html>';
        }
        default_type text/html;
}

server {
        listen 8082;
        server_name blue_page;
        location / {
                return 200 '<html><body style="background-color:blue;"><h1>Blue Page</h1></body></html>';
        }
        default_type text/html;
}

server {
        listen 80 ;
        # listen 443 ssl;
       # listen [::]:443;

       # ssl_certificate /var/www/html/cert/fullchain.pem;
       # ssl_certificate_key /var/www/html/cert/privkey.pem;


        server_name _;
        root /var/www/html;
        index index.html index.nginx-debian.html;

        location ~ /.well-known/acme-challenge/ {
                root /var/www/certbot;
        }

        location / {
                try_files $uri $uri/ =404;

        }

        location /secondpage {
                root /var/www/html;
        }


        location /music {
                alias /var/www/html/music.mp3;
                default_type audio/mpeg;
                add_header Content-Disposition "attachment; filename=music.mp3";
        }

        location /info.php {
                proxy_pass http://apache:8080;
        }

        location /secondserver {
                proxy_pass https://pikabu.ru/best;
        }

        location /redblue {
                proxy_pass http://backend_servers;
                proxy_set_header Host $host;
        }

        location /image1 {
                image_filter rotate 180;
                alias /var/www/html/img/poebat.jpg;
        }

        location /image2 {
                alias /var/www/html/img/poxuy.png;
                default_type image/png;
        }


        location /500 {
                return 500;
        }
        
}
```



это итоговая версия использованная для docker