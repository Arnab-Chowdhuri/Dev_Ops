import boto3

iam_user=boto3.client('iam')

response = iam_user.list_users()
print("Users are : ")
for user in response['Users']:
    print(f'- {user['UserName']}')