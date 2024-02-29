import boto3

# Create an EC2 client
ec2_client = boto3.client('ec2')

# Specify the AMI (Amazon Machine Image) ID for the desired operating system
ami_id = 'ami-097cb86b4e1b9bf21'  # Replace with your AMI ID

# Specify the instance type
instance_type = 't2.micro'  # Change as per your requirements

# Specify the key pair name for SSH access
key_name = 'ARC1'  # Replace with your key pair name

# Specify the security group IDs
security_group_ids = ['sg-08ac824167ef1370d']  # Replace with your security group IDs

# Specify the subnet ID
subnet_id = 'subnet-062e6918b46063aa0'  # Replace with your subnet ID

instance_name = "Test_boto3_I4"

# Launch the EC2 instance
response = ec2_client.run_instances(
    ImageId=ami_id,
    InstanceType=instance_type,
    KeyName=key_name,
    MinCount=1,
    MaxCount=1,
    NetworkInterfaces=[
        {
            'AssociatePublicIpAddress': True,
            'DeviceIndex': 0,
            'Groups': security_group_ids,  # Specify your security group ID(s) here
            'SubnetId': subnet_id,
        }
    ],
    TagSpecifications=[
        {
            'ResourceType': 'instance',
            'Tags': [
                {
                    "Key": "Name",
                    "Value": instance_name
                }
            ]
        }
    ]
)

print(response)
print()

# Get the instance ID
instance_id = response['Instances'][0]['InstanceId']
print(f"EC2 instance created with ID: {instance_id}")
