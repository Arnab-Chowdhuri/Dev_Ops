import boto3

s3 = boto3.client('s3')

bucket_name = 'king-arc-3rd-boto3-bucket'
object_key_path = 'folder/upload_from_boto3.txt'   # path inside the bucket (if there is any folder inside bucket)
local_file_path = 'S3/deletefile.txt'  # Specify the local path where you want to save the downloaded file

s3.download_file(bucket_name, object_key_path, local_file_path)