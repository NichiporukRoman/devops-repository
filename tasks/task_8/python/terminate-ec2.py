import boto3

def terminate_ec2_instance(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, INSTANSE_ID):

    session = boto3.Session(
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
        region_name='us-east-1'
    )
    client = session.client('ec2')
    
    response = client.terminate_instances(
        InstanceIds=[INSTANSE_ID],
        DryRun=False  # Убедитесь, что DryRun=False для выполнения
    )

    print(response)
    


AWS_ACCESS_KEY_ID = input("AWS_ACCESS_KEY_ID: ")
AWS_SECRET_ACCESS_KEY = input("AWS_SECRET_ACCESS_KEY: ")
INSTANSE_ID = input("INSTANSE_ID: ")
instance_id = terminate_ec2_instance(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, INSTANSE_ID)
