import boto3

# Create a session using the AWS configuration
session = boto3.Session()

# Get the region from the session
m_region = session.region_name