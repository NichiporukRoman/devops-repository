```
groups:
 - name: example
   rules:
   - alert: InstanceDown
     expr: up == 0
     for: 1m
```