import boto3

# RDS parameters
db_instance_identifier = 'instance-from-boto3'
db_instance_class = 'db.t2.micro'
engine = 'mysql'
master_username = 'admin'
master_password = 'Supriyo12'
allocated_storage = 20
availability_zone = 'ap-south-1a'

# Create RDS client
rds_client = boto3.client('rds')

# Create MySQL RDS instance
response = rds_client.create_db_instance(
    DBInstanceIdentifier=db_instance_identifier,
    AllocatedStorage=allocated_storage,
    DBInstanceClass=db_instance_class,
    Engine=engine,
    MasterUsername=master_username,
    MasterUserPassword=master_password,
    AvailabilityZone=availability_zone,
    MultiAZ=False,
    EngineVersion='5.7',
    PubliclyAccessible=False,
    StorageType='gp2',
    BackupRetentionPeriod=1,
    Tags=[
        {
            'Key': 'Name',
            'Value': 'MyMySQLInstance'
        },
        # Add more tags as needed
    ],
)

print(f"Creating RDS instance '{db_instance_identifier}'...")

# Wait for the RDS instance to be available
rds_client.get_waiter('db_instance_available').wait(DBInstanceIdentifier=db_instance_identifier)

print(f"RDS instance '{db_instance_identifier}' created successfully.")
