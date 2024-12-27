apt update
apt install git python3 python3-pip -y
git clone https://github.com/kubernetes-incubator/kubespray.git
cd kubespray
pip install -r requirements.txt
ansible --version
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(192.168.1.241 192.168.1.241 192.168.1.242 192.168.1.243 192.168.1.244 192.168.1.245)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
vi inventory/mycluster/hosts.yaml