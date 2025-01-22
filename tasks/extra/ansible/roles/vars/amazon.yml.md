```
amazon_packages:
  - git
  - docker
  
docker_compose_url: "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64"
  
ssh_key_src: "/home/rodion0011/.ssh/key_for_ansible"
ssh_key_dest: "/home/ec2-user/.ssh/id_ed25519"

certs_dir: "/home/ec2-user/nginx/certs"
certs_owner: "ec2-user"
  
git_repo:
  url: "git@github.com:RodionLeon/task15.git"
  dest: "/home/ec2-user/task15"
  version: "main"
  key_file: "/home/ec2-user/.ssh/id_ed25519"
  
cert_files:
  - src: "/home/rodion0011/task15/fullchain.pem"
    dest: "/home/ec2-user/nginx/certs/fullchain.pem"
    owner: "root"
    group: "root"
    mode: "0644"

  - src: "/home/rodion0011/task15/privkey.pem"
    dest: "/home/ec2-user/nginx/certs/privkey.pem"
    owner: "root"
    group: "root"
    mode: "0600"
```