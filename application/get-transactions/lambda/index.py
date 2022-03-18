import os
import boto3
import logging
import json
import decimal

from dotenv import load_dotenv
from boto3.dynamodb.conditions import Key

load_dotenv()

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def decimal_default(obj):
    if isinstance(obj, decimal.Decimal):
        return float(obj)
    raise TypeError

def lambda_handler(event, context):
    try:
        user = event['queryStringParameters']['user']
        logger.info(f"getting transactions from: {user}")

        transactions = _get_transactions_by_user(user)
        logger.info(f"transactions recovered")

        return _response(200, json.dumps(transactions, default=decimal_default))
    except:
        return _response(500, "Internal Server Error")

def _get_transactions_by_user(user):
    table = _get_table('Transactions')
    response = table.query(
        KeyConditionExpression='#pk = :pk_value', 
        ExpressionAttributeNames={'#pk': 'user'},
        ExpressionAttributeValues={':pk_value': user}
    )
    return response['Items']

def _get_table(table_name):
    boto3.setup_default_session(
        aws_access_key_id=os.environ.get("AWS_ACCESS_KEY"),
        aws_secret_access_key=os.environ.get("AWS_ACCESS_SECRET_KEY"),
        region_name=os.environ.get("AWS_REGION")
    )
    dynamodb = boto3.resource('dynamodb', endpoint_url=os.environ.get("DYNAMODB_ENDPOINT_URL"))
    return dynamodb.Table(table_name)

def _response(status_code, body):
    return {
        "statusCode": status_code,
        "body": body
    }