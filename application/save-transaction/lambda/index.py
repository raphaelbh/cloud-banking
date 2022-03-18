import os
import logging
import uuid
import json
import boto3

from decimal import Decimal
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        for record in event['Records']:
            
            body = json.loads(record['body'])
            message = json.loads(body['Message'].replace("\'", "\""))
            transaction_id = str(uuid.uuid4())
            logger.info(f"saving transaction {transaction_id}")

            _save_transaction({
                'user': message['user'],
                'amount': Decimal(message['amount']),
                'type': message['type'],
                'transaction_id': transaction_id,
                'date_time': str(datetime.now())
            })
            logger.info(f"transaction saved")
    except:
        raise Exception("Internal Server Error")

def _save_transaction(transaction):
    table = _get_table('Transactions')
    response = table.put_item(Item=transaction)
    return response

def _get_table(table_name):
    boto3.setup_default_session(
        aws_access_key_id=os.environ.get("AWS_ACCESS_KEY"),
        aws_secret_access_key=os.environ.get("AWS_ACCESS_SECRET_KEY"),
        region_name=os.environ.get("AWS_REGION")
    )
    dynamodb = boto3.resource('dynamodb', endpoint_url=os.environ.get("DYNAMODB_ENDPOINT_URL"))
    return dynamodb.Table(table_name)