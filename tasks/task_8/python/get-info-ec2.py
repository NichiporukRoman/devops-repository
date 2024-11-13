import boto3
from datetime import datetime, timedelta

def get_instance_info(INSTANSE_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY):
    session = boto3.Session(
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
        region_name='us-east-1'  
    )


    ec2 = session.resource('ec2')
    instance = ec2.Instance(INSTANSE_ID)
    volumes = instance.volumes.all()
    size = 0
    for volume in volumes:
        size += volume.size
    instance_info = {
        'Public IP': instance.public_ip_address,
        'Private IP': instance.private_ip_address,
        'OS': instance.platform or 'Linux/UNIX',
        'Metrics': get_instance_metrics(INSTANSE_ID, session), 
        'Size': str(size)+" GB", 
        'Instance Type': instance.instance_type
    }

    print("Instance Information:")
    for key, value in instance_info.items():
        print(f"{key}: {value}")
    
    return instance_info


def get_instance_metrics(instance_id, session):
    cloudwatch = session.client('cloudwatch')
    
    cpu_metrics = cloudwatch.get_metric_statistics(
        Period=300,
        StartTime=datetime.utcnow() - timedelta(seconds=600),
        EndTime=datetime.utcnow(),
        MetricName='CPUUtilization',
        Namespace='AWS/EC2',
        Statistics=['Average'],
        Dimensions=[{'Name': 'InstanceId', 'Value': instance_id}]
    )
    
    return cpu_metrics['Datapoints'][0]['Average']-cpu_metrics['Datapoints'][0]['Average']%0.1


AWS_ACCESS_KEY_ID = input("AWS_ACCESS_KEY_ID: ")
AWS_SECRET_ACCESS_KEY = input("AWS_SECRET_ACCESS_KEY: ")
INSTANSE_ID = input("INSTANSE_ID: ")

get_instance_info(INSTANSE_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
