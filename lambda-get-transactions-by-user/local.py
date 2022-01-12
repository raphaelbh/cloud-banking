import os
from  index import lambda_handler

###  ENVIRONMENT VARIABLES  ###
os.environ["LOCALSTACK_HOSTNAME"] = 'localhost'

event = {
    'queryStringParameters': {
        'user': 'john'
    }
}

context = {}

###  CALLING LAMBDA FUNCTION  ###
response = lambda_handler(event, context)
print(response)