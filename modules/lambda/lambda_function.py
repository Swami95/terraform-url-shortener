import json
import boto3
import os
import random
import string

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

def generate_short_code():
    return ''.join(random.choices(string.ascii_letters + string.digits, k=6))

def lambda_handler(event, context):
    method = event['httpMethod']
    
    if method == "POST":
        body = json.loads(event['body'])
        original_url = body['url']
        short_code = generate_short_code()
        
        table.put_item(Item={"short_code": short_code, "original_url": original_url})
        
        return {
            "statusCode": 200,
            "body": json.dumps({"short_url": f"https://short.ly/{short_code}"})
        }
    
    elif method == "GET":
        short_code = event['pathParameters']['short_code']
        response = table.get_item(Key={"short_code": short_code})
        
        if 'Item' in response:
            return {
                "statusCode": 302,
                "headers": {"Location": response['Item']['original_url']}
            }
        else:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": "URL not found"})
            }
