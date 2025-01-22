```
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:
- job_name: nginx_logs
  static_configs:
  - targets:
      - localhost
    labels:
      job: logs-nginx
      __path__: /var/log/nginx/*log

- job_name: apache_logs
  static_configs:
  - targets:
      - localhost
    labels:
      job: logs-apache
      __path__: /var/log/apache2/*log
```
