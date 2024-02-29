import boto3

ec2_client = boto3.client('ec2')

print()
no=int(input("How many instance you want to terminate : "))
instance_ids=[]
for i in range(no):
    data=input(f"Give the ID for Instance {i+1} : ")
    instance_ids.append(data)

response = ec2_client.terminate_instances(
    InstanceIds=instance_ids
)

print()
print(response)