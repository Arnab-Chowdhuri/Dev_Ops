import boto3

s3 = boto3.client('s3')

path_of_file='S3/deletefile.txt'
bucket_name='king-arc-3rd-boto3-bucket'
S3_key='deleteit.txt'  # path inside the bucket (if there is any folder inside bucket)

s3.upload_file(path_of_file, bucket_name, S3_key)