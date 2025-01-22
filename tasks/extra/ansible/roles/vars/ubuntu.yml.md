```
ubuntu_packages:
  - ca-certificates
  - curl
  - git
  - python3-pymysql
  - python3-mysqldb
  - mysql-server
  - mysql-client
  - docker.io

docker_compose_url: "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64"
  
ssh_key_src: "/home/rodion0011/.ssh/key_for_ansible"
ssh_key_dest: "/home/ubuntu/.ssh/id_ed25519"
  
certs_dir: "/home/ubuntu/nginx/certs"
certs_owner: "ubuntu"
  
git_repo:
  url: "git@github.com:RodionLeon/task15.git"
  dest: "/home/ubuntu/task15"
  version: "main"
  key_file: "/home/ubuntu/.ssh/id_ed25519"
  
cert_files:
  - src: "/home/rodion0011/task15/fullchain.pem"
    dest: "/home/ubuntu/nginx/certs/fullchain.pem"
    owner: "root"
    group: "root"
    mode: "0644"
    
  - src: "/home/rodion0011/task15/privkey.pem"
    dest: "/home/ubuntu/nginx/certs/privkey.pem"
    owner: "root"
    group: "root"
    mode: "0600"
```