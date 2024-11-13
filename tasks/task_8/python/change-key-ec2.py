import paramiko


host = input("host: ")
user = input("user: ")
key_path = input("key_path: ")
new_public_key = input("new_public_key: ")

# host = '34.229.62.135'
# user = 'ubuntu'
# port = 22
# key_path = 'E:/playsdev-tranee/tasks/task_8/python/task8.pem'
# new_public_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEJtqQNxwBIAn4kHFsorkXJ30lLdHPI2i6MzqVV0CTmkLc29KgJA3OcVRoeWX1MAgWdR0ONnaooAUXuQrdUX9c1G/EgPGb54vZmupLXcekstmHochvx8FlgB6l1YlVDe2mxQHv3F787FRV/ypgN5XQgSShLkfsi4dtVjYOQNxxNdJkxUtK+L0HjiELpcqa9OwGO4zza2xRp2M8nA6r6ApsbQB3pHwUEZbkbAbcUR8p3Keq4FSnoIbCS6hSFmpvHKIlBOJQ9XmNDJS0X24l0DRpcbUXOURp3e2UY0YL9mJkJX115Cc+hIw/Sl89/s8h2HIH/X3azaIlnpM5SdBOSAdD'

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
    private_key = paramiko.RSAKey.from_private_key_file(key_path)
    client.connect(hostname=host, username=user, port=22, pkey=private_key)
    
    
    client.exec_command('echo "{new_public_key}" > ~/.ssh/authorized_keys')
    
    print("New public key added to authorized_keys")
    
finally:
    client.close()
