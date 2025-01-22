```
mysql_root_password: "root"
  mysql_databases:
        - name: mydatabase
          encoding: utf8
          collation: utf8_general_ci

  mysql_users:
        - name: myuser
          password: "user"
          priv: "mydatabase.*:ALL"
```