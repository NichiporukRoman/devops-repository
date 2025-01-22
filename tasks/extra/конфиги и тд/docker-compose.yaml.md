```
version: '3'
services:
  nginx:
    image: rodion0013/trainee:nginx
    volumes:
      - ./logs:/var/log/nginx
      - ./cert/fullchain.pem:/var/www/html/cert/fullchain.pem
      - ./cert/privkey.pem:/var/www/html/cert/privkey.pem
    ports:
      - "80:80"
      - "443:443"
  apache:
    container_name: apache
    image: apache
    volumes:
      - ./logs-apache:/var/log/apache2
    ports:
      - "8080:8080"

  promtail:
    image: grafana/promtail:3.0.0
    volumes:
      - ./promtail-config.yaml:/etc/promtail/config.yaml
      - ./logs:/var/log/nginx
      - ./logs-apache:/var/log/apache2
    command: -config.file=/etc/promtail/config.yaml

  loki:
    image: grafana/loki:3.0.0
    ports:
      - "3100:3100"
    volumes:
      - ./loki-config.yml:/etc/loki/loki-config.yaml

  grafana:
    image: grafana/grafana-enterprise
    container_name: grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_SERVER_PROTOCOL=https
    volumes:
      - grafana-data:/var/lib/grafana
      - ./cert/fullchain.pem:/var/lib/grafana/ssl/grafana.crt
      - ./cert/privkey.pem:/var/lib/grafana/ssl/grafana.key
      - ./grafana.ini:/etc/grafana/grafana.ini
    ports:
      - '3000:3000'

  prometheus:
    image: prom/prometheus
    volumes:
      - "./prometheus.yml:/etc/prometheus/prometheus.yml"
      - "./rules.yml:/etc/prometheus/rules.yml"
      - "./alert.rules.yml:/etc/prometheus/alert.rules.yml"
    networks:
      - network
    ports:
      - 9090:9090

  node-exporter:
    image: prom/node-exporter
    networks:
      - network
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.rootfs=/rootfs'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
    ports:
      - 9100:9100

  alert-manager:
    image: prom/alertmanager
    volumes:
      - "./alertmanager.yml:/alertmanager/alertmanager.yml"
      - "./telegram.tmpl:/alertmanager/telegram.tmpl"
    command:
      - '--config.file=/alertmanager/alertmanager.yml'
    networks:
      - network
    ports:
      - 9093:9093

networks:
  network:
    driver: bridge

volumes:
  grafana-data:
```
