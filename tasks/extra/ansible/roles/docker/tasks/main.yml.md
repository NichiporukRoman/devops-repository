```
- name: Load variables for Amazon
  include_vars: "../vars/amazon.yml"
  when: ansible_distribution == "Amazon"

- name: Load variables for Ubuntu
  include_vars: "../vars/ubuntu.yml"
  when: ansible_distribution == "Ubuntu"

- name: Include Amazon Linux tasks
  include_tasks: amazon.yml
  when: ansible_distribution == "Amazon"
  
- name: Include Ubuntu tasks
  include_tasks: ubuntu.yml
  when: ansible_distribution == "Ubuntu"
```