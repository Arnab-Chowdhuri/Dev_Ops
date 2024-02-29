import boto3

# Create an EC2 client
ec2 = boto3.client('ec2')

# Use the describe_instances method to get information about all instances

def list_all_Instance():
    response = ec2.describe_instances()

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:

            print()
            print(f"Instance NAME : {instance['Tags'][0]['Value']}")
            print(f"State : {instance['State']['Name']}")
            print(f"Instance ID : {instance['InstanceId']}")
            print(f"Public IP : {instance.get('PublicIpAddress', 'N/A')}")
            print(f"Private IP : {instance.get('PrivateIpAddress', 'N/A')}")

def list_all_Instance_in_VPC(vpc_id):
    response = ec2.describe_instances(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:

            print()
            print(f"Instance NAME : {instance['Tags'][0]['Value']}")
            print(f"State : {instance['State']['Name']}")
            print(f"Instance ID : {instance['InstanceId']}")
            print(f"Public IP : {instance.get('PublicIpAddress', 'N/A')}")
            print(f"Private IP : {instance.get('PrivateIpAddress', 'N/A')}")


print()
inp=int(input("What you want to choose: \n List of all Instance : 1 \n List of Instance in a VPC : 2 \n\n Choose your no : "))
if(inp==1):
    list_all_Instance()
elif(inp==2):
    vpc_id=input("Enter the VPC ID : ")
    list_all_Instance_in_VPC(vpc_id)