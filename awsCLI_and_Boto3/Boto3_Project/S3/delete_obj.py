import boto3

s3 = boto3.client('s3')

bucket_name='king-arc-3rd-boto3-bucket'
file_path='deleteit.txt'  # path inside the bucket (if there is any folder inside bucket)

s3.delete_object(Bucket=bucket_name, Key=file_path)