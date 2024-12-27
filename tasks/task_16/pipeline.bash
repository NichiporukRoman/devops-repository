export UBUNTU_IP=$(terraform output -raw ips)
ansible-playbook /home/roman/playsdev-tranee/tasks/task_16/ansible/playbook.yml
