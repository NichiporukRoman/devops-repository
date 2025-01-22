```
#!/bin/bash

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get install -y postgresql postgresql-contrib

sudo systemctl start postgresql

sudo systemctl enable postgresql
```