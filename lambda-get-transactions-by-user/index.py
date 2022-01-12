import os
import json
import logging
import boto3
from boto3.dynamodb.conditions import Key

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
  user = event['queryStringParameters']['user']
  transactions = get_transactions_by_user(user)
  response = {
    'isBase64Encoded': False,
    'statusCode': 200,
    'headers': {},
    'multiValueHeaders': {},
    'body': str(transactions)
  }
  return response

def get_transactions_by_user(user):
  dynamodb = boto3.resource('dynamodb', endpoint_url=dynamodb_endpoint_url())
  transactionsTable = dynamodb.Table('Transactions')
  response = transactionsTable.query(
        KeyConditionExpression = Key('user').eq(user)
  )
  return response['Items']

def dynamodb_endpoint_url():
  LOCALSTACK_HOSTNAME = os.environ.get("LOCALSTACK_HOSTNAME")
  if LOCALSTACK_HOSTNAME:
    return f"http://{LOCALSTACK_HOSTNAME}:4566"
  else:
    return os.environ.get("DYNAMODB_ENDPOINT_URL")