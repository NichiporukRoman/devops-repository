```
- name: Install and Docker container
  hosts: all
  become: true
  roles:
    - role: docker
    - role: container
   
- hosts: ubuntu
  become: yes
  vars_files:
    - vars/main.yml
  roles:
    - { role: geerlingguy.mysql }
```