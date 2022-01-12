import os
import logging
import uuid
import json
import boto3
from decimal import Decimal
from datetime import datetime

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
  logger.info('Lambda save transaction start process')

  for record in event['Records']:
    body = json.loads(record['body'])
    message = json.loads(body['Message'])
    logger.info('Body Message: ' + str(message))

    saved_transaction = save_transaction({
      'user': message['user'],
      'amount': Decimal(message['amount']),
      'type': message['type'],
      'transaction_id': str(uuid.uuid4()),
      'date_time': str(datetime.now())
    })
    logger.info('Transaction saved: ' + str(saved_transaction))

  logger.info('Lambda save transaction end process')

def save_transaction(transaction):
  dynamodb = boto3.resource('dynamodb', endpoint_url=dynamodb_endpoint_url())
  transactionsTable = dynamodb.Table('Transactions')
  response = transactionsTable.put_item(Item=transaction)
  return response

def dynamodb_endpoint_url():
  LOCALSTACK_HOSTNAME = os.environ.get("LOCALSTACK_HOSTNAME")
  if LOCALSTACK_HOSTNAME:
    return f"http://{LOCALSTACK_HOSTNAME}:4566"
  else:
    return os.environ.get("DYNAMODB_ENDPOINT_URL")