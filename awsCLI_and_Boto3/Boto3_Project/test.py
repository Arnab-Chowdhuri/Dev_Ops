import boto3

# Use the default AWS configuration for the region
client = boto3.client('s3')

# Specify the bucket name and create the bucket with the region constraint
response = client.create_bucket(
    Bucket='djbvfsjdghjshjkhsdkjhj'
)
print(response)
