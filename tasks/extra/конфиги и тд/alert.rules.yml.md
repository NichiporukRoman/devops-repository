```
groups:
  - name: CPU_Usage_alert
    rules:
      - alert: HighCPUUsage
        expr: 100 * (1 - avg by (instance) (rate(node_cpu_seconds_total{env="task18", mode="idle"}[1m]))) > 5
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on {{ $labels.name }} ({{ $labels.instance }})"
          description: "CPU usage on instance {{ $labels.instance }} has been above 5% for the last 1 minutes."

      - alert: HighMemoryUsage
        expr: (node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes{env="task18(2)"}) / node_memory_MemTotal_bytes > 0.1
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "High Memory usage detected"
          description: "Instance {{ $labels.name }} ({{ $labels.instance }}) memory usage > 10% for 1 minutes"
```
