import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the bucket name and object key
bucket_name = 'king-arc-3rd-boto3-bucket'
object_path = 'folder/upload_from_boto3.txt'

# Use the get_object method to retrieve the object
response = s3.get_object(Bucket=bucket_name, Key=object_path)

# Access the content of the object
object_content = response['Body'].read()

# Do something with the object content
print(object_content)
