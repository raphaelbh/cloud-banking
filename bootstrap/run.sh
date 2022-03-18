#!/bin/bash
set -e

echo "################################# AWS STARTUP #################################"


echo -ne "===> Setting up local aws account"
aws configure set aws_access_key_id localstack > /dev/null
aws configure set aws_secret_access_key localstack > /dev/null
aws configure set region us-east-1 > /dev/null
echo "... Done"


echo -ne "===> Creating resources"
aws cloudformation create-stack --stack-name bank --template-body file://bootstrap/template.yaml --endpoint-url http://localstack:4566 > /dev/null
aws cloudformation wait stack-create-complete --stack-name bank --endpoint-url http://localstack:4566 > /dev/null
echo "... Done"


echo -ne "===> Generating mass of data"
aws dynamodb put-item --endpoint-url http://localstack:4566 --table-name Transactions --item '{"user": {"S": "john"}, "transaction_id": {"S": "27a86dd4-d69b-4ed3-8ede-116093913d24"}, "amount": {"N": "99.99"}, "type": {"S": "PURCHASE"}, "date_time": {"S": "2022-03-04 00:22:39 UTC+0000"}}' > /dev/null
aws dynamodb put-item --endpoint-url http://localstack:4566 --table-name Transactions --item '{"user": {"S": "john"}, "transaction_id": {"S": "8035cc8c-0ea7-484a-8708-058d646f5731"}, "amount": {"N": "11.11"}, "type": {"S": "PURCHASE"}, "date_time": {"S": "2022-04-05 00:11:43 UTC+0000"}}' > /dev/null
echo "... Done"


echo -ne "===> Updating save transaction lambda"
lambda_name="SaveTransactionLambda"
lambda_directory="./application/save-transaction/lambda"
(cd ${lambda_directory} && rm -f -r -- __pycache__ && rm -f -- lambda.zip && zip -r lambda.zip ./*) > /dev/null
aws lambda update-function-code --endpoint-url http://localstack:4566 --function-name ${lambda_name} --zip-file fileb://${lambda_directory}/lambda.zip > /dev/null
(cd ${lambda_directory} && rm -f -- lambda.zip) > /dev/null
echo "... Done"


echo -ne "===> Updating get transactions lambda"
lambda_name="GetTransactionsByUserLambda"
lambda_directory="./application/get-transactions/lambda"
(cd ${lambda_directory} && rm -f -r -- __pycache__ && rm -f -- lambda.zip && zip -r lambda.zip ./*) > /dev/null
aws lambda update-function-code --endpoint-url http://localstack:4566 --function-name ${lambda_name} --zip-file fileb://${lambda_directory}/lambda.zip > /dev/null
(cd ${lambda_directory} && rm -f -- lambda.zip) > /dev/null
echo "... Done"


echo -ne "===> Getting get transactions rest api address"
rest_api_id=`aws apigateway get-rest-apis --endpoint-url http://localstack:4566 | jq -r '.items[]|select(.name == "get-transactions-api")|.id'`
rest_api_address="http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions"
echo "... Done"


echo "API: $rest_api_address"


echo "################################# AWS STARTUP #################################"