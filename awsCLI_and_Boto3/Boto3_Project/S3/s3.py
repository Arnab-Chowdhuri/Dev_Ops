import boto3
from region import m_region

# Use the default AWS configuration for the region
s3 = boto3.client('s3')


# List all S3 buckets
response = s3.list_buckets()
buck_list=[]
# Print the names of all buckets
for bucket in response['Buckets']:
    buck_list.append(bucket['Name'])


def bucket_list():
    # List all S3 buckets
    response = s3.list_buckets()
    # Print the names of all buckets
    print("S3 Buckets:")
    for bucket in response['Buckets']:
        print(f"- {bucket['Name']}")


# Specify the bucket name and create the bucket with the region constraint
def bucket_create(buck):
    response = s3.create_bucket(
        Bucket=buck,
        CreateBucketConfiguration={'LocationConstraint': m_region}
    )
    print(response)


# response = client.get_bucket_acl(
#     Bucket='king-arc-2nd-boto3-bucket'
# )
# x=response['Owner']
# print(x)


def objects_in_bucket(buck):
    if(buck in buck_list):
        response = s3.list_objects(
            Bucket=buck
        )
        for obj in response.get('Contents', []):
            print(f"- {obj['Key']}")
    else:
        print("This bucket is not in your s3")


print()
inp=int(input("What you want to choose: \n Create obj : 1 \n List of Obj : 2 \n List of buckets : 3 \n\n Choose your no : "))
if(inp==1):
    buck=input("Enter the name of bucket : ")
    bucket_create(buck)
elif(inp==2):
    buck=input("Enter the name of bucket : ")
    objects_in_bucket(buck)
elif(inp==3):
    bucket_list()
