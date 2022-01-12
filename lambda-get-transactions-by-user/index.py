def lambda_handler(event, context):
  user = event['queryStringParameters']['user']
  response = {
    'isBase64Encoded': False,
    'statusCode': 200,
    'headers': {},
    'multiValueHeaders': {},
    'body': user + ' transactions!'
  }
  return response