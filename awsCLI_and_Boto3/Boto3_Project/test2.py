import boto3

# Create a session using the AWS configuration
session = boto3.Session()

# Use the session to create the S3 client
s3_client = session.client('s3')

# Specify the bucket name and create the bucket with the region constraint
response = s3_client.create_bucket(
    Bucket='guyvhlugerayubduvhdsjaf'
)
print(response)
