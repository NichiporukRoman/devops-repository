```
global:
  scrape_interval: 10s
  evaluation_interval: 10s

rule_files:
  - rules.yml
  - alert.rules.yml

alerting:
  alertmanagers:
   - static_configs:
     - targets:
        - 54.166.127.117:9093

scrape_configs:
 - job_name: prometheus
   static_configs:
    - targets:
       - 54.166.127.117:9090
 - job_name: "node-exporter-master"
   ec2_sd_configs:
   - port: 9100
     filters:
       - name: tag:env
         values: ["task18"]
   relabel_configs:
     - source_labels: [__meta_ec2_private_ip]
       target_label: instance
     - source_labels: [__meta_ec2_tag_name]
       target_label: name
     - source_labels: [__meta_ec2_tag_env]
       target_label: env

 - job_name: "node-exporter-server-ubuntu"
   ec2_sd_configs:
   - port: 9100
     filters:
       - name: tag:env
         values: ["task18(2)"]
   relabel_configs:
     - source_labels: [__meta_ec2_private_ip]
       target_label: instance
     - source_labels: [__meta_ec2_tag_name]
       target_label: name
     - source_labels: [__meta_ec2_tag_env]
       target_label: env
```