```
- name: Install required packages on Amazon
  yum:
    name: "{{ amazon_packages }}"
    state: present
    
- name: Start Docker service
  service:
    name: docker
    state: started
    enabled: true

- name: Install Docker Compose
  get_url:
    url: "{{ docker_compose_url }}"
    dest: /usr/local/bin/docker-compose
    mode: '0755'

- name: Copy SSH private key
  copy:
    src: "{{ ssh_key_src }}"
    dest: "{{ ssh_key_dest }}"
    mode: '0600'

- name: Create directory for certificates
  file:
    path: "{{ certs_dir }}"
    state: directory
    owner: "{{ certs_owner }}"
    mode: '0755'

- name: Clone repository from GitHub
  git:
    repo: "{{ git_repo.url }}"
    dest: "{{ git_repo.dest }}"
    version: "{{ git_repo.version }}"
    accept_hostkey: yes
    key_file: "{{ git_repo.key_file }}"

- name: Copy certificate files
  with_items: "{{ cert_files }}"
  ansible.builtin.copy:
    src: "{{ item.src }}"
    dest: "{{ item.dest }}"
    decrypt: yes
    owner: "{{ item.owner }}"
    group: "{{ item.group }}"
    mode: "{{ item.mode }}"
```