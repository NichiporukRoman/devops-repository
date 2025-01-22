```
mport boto3
import paramiko
import time

ec2 = boto3.client('ec2')

instances = []

def create_instance():

    response = ec2.run_instances(

        ImageId='ami-0866a3c8686eaeeba',
        InstanceType='t2.micro',
        MinCount=1,
        MaxCount=1,
        KeyName='rodionTask2Key',
        SecurityGroupIds=['sg-02a2f629b787443d4'],
        SubnetId='subnet-087a3f6490ed9e479'

    )

    instance_id = response['Instances'][0]['InstanceId']
    
    instances.append(instance_id)

    print(f"Successfully launched EC2 instance with Instance ID: {instance_id}")

    waiter = ec2.get_waiter('instance_running')

    waiter.wait(InstanceIds=[instance_id])

    instance_info = ec2.describe_instances(InstanceIds=[instance_id])

    instance_details = instance_info['Reservations'][0]['Instances'][0]

    # Собранная информация о новосозданном инстансе

    instance_data = {

        "Instance ID": instance_details.get('InstanceId'),
        "Instance Type": instance_details.get('InstanceType'),
        "Private IP": instance_details.get('PrivateIpAddress'),
        "Public IP": instance_details.get('PublicIpAddress'),
        "State": instance_details.get('State')['Name'],
        "Platform": instance_details.get('Platform', 'Linux/Unix'),
        "Launch Time": instance_details.get('LaunchTime').strftime("%Y-%m-%d %H:%M:%S"),
        "VPC ID": instance_details.get('VpcId'),
        "Subnet ID": instance_details.get('SubnetId'),
    }

    print("\nInstance Details:")

    for key, value in instance_data.items():

        print(f"{key}: {value}")

def get_instance_info(instance_id):

    """Retrieve and print detailed information of a specific instance."""

    instance_info = ec2.describe_instances(InstanceIds=[instance_id])

    print("\nComplete Instance Information:")

    print(instance_info)

def add_new_ssh_key(public_ip, old_private_key_path, new_public_key_path, retries=5, delay=10):

    old_key = paramiko.RSAKey.from_private_key_file(old_private_key_path)

    for attempt in range(retries):

        try:

            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(public_ip, username='ubuntu', pkey=old_key)
            with open(new_public_key_path, 'r') as file:

                new_pub_key = file.read().strip()

            ssh.exec_command(f'echo "{new_pub_key}" > ~/.ssh/authorized_keys')
            print("New SSH key added successfully.")
            return

        except Exception as e:

            print(f"Attempt {attempt + 1}/{retries} failed: {e}")
            time.sleep(delay)

    print("Failed to connect and add new SSH key after multiple attempts.")

def verify_new_key_connection(public_ip, new_private_key_path, retries=5, delay=10):

    new_key = paramiko.RSAKey.from_private_key_file(new_private_key_path)
    
    for attempt in range(retries):

        try:

            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(public_ip, username='ubuntu', pkey=new_key)
            print("Successfully connected with the new SSH key.")
            return

        except Exception as e:

            print(f"Attempt {attempt + 1}/{retries} failed: {e}")
            time.sleep(delay)

    print("Failed to connect with the new SSH key after multiple attempts.")

def terminate_instance(instance_id):

    ec2.terminate_instances(InstanceIds=[instance_id])

    print(f"Terminated EC2 instance with Instance ID: {instance_id}")

    if instance_id in instances:

        instances.remove(instance_id)

def main_menu():

    while True:

        print("\nSelect an option:")
        print("1. Create a new EC2 instance and show details")
        print("2. Change SSH key on a specific instance")
        print("3. Terminate a specific EC2 instance")
        print("4. Show instance details by ID")
        print("5. Exit")

        choice = input("Enter your choice: ").strip()

        if choice == '1':

            create_instance()

        elif choice == '2':

            if not instances:

                print("No instances available.")

                continue

            print("Available instances:", instances)

            instance_id = input("Enter Instance ID to change SSH key: ").strip()

            public_ip = input("Enter public IP of the instance: ").strip()

            old_private_key_path = '/home/rodion0011/rodionTask2Key.pem'

            new_public_key_path = '/home/rodion0011/newKey.pub'

            new_private_key_path = '/home/rodion0011/newKey'

            add_new_ssh_key(public_ip, old_private_key_path, new_public_key_path)

            verify_new_key_connection(public_ip, new_private_key_path)

        elif choice == '3':

            if not instances:

                print("No instances available.")

                continue

            print("Available instances:", instances)

            instance_id = input("Enter Instance ID to terminate: ").strip()

            terminate_instance(instance_id)

        elif choice == '4':

            instance_id = input("Enter Instance ID to display details: ").strip()

            get_instance_info(instance_id)

        elif choice == '5':

            print("Exiting.")

            break

        else:

            print("Invalid choice. Please try again.")

main_menu()
```
