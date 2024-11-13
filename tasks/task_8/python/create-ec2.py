import boto3

def create_ec2_instance(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY):

    session = boto3.Session(
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
        region_name='us-east-1'
    )

    ec2 = session.resource('ec2')
    
    instance = ec2.create_instances(
        ImageId='ami-0866a3c8686eaeeba',       
        InstanceType='t2.nano',    
        KeyName='task8'
    )
    
    print(f"Instance created with ID: {instance[0].id}")
    return instance[0].id

AWS_ACCESS_KEY_ID = input("AWS_ACCESS_KEY_ID: ")
AWS_SECRET_ACCESS_KEY = input("AWS_SECRET_ACCESS_KEY: ")
create_ec2_instance(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
