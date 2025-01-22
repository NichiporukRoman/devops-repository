```
- name: Change to the directory with docker-compose.yml
  command: chdir=/home/{{ ansible_user }}/task15 pwd

- name: Build and start containers using Docker Compose
  shell: |
    docker-compose up -d
  args:
    chdir: /home/{{ ansible_user }}/task15
```