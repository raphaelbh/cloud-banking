#!/bin/sh

SCRIPT_PATH=`readlink -f "$0"`
SCRIPT_DIR=`dirname "$SCRIPT_PATH"`

# creating stack
#aws cloudformation validate-template --endpoint-url http://localhost:4566 --template-body file://cloudformation/bank.yml
aws cloudformation create-stack --endpoint-url http://localhost:4566 --stack-name bank --template-body file://cloudformation/bank.yml
#aws cloudformation list-stack-resources --endpoint-url http://localhost:4566 --stack-name bank
sleep 5
echo "aws resources created"

# update lambda-save-transaction
$SCRIPT_DIR/update_lambda.sh SaveTransactionLambda
#cd lambda-save-transaction && rm -f -r -- __pycache__ && rm -f -- lambda.zip && zip -r lambda.zip ./*)
#aws lambda update-function-code --endpoint-url http://localhost:4566 --function-name SaveTransactionLambda --zip-file fileb://lambda-save-transaction/lambda.zip
echo "lambda-save-transaction updated"

# update lambda-get-transactions-by-user
$SCRIPT_DIR/update_lambda.sh GetTransactionsByUserLambda
#(cd lambda-get-transactions-by-user && rm -f -r -- __pycache__ && rm -f -- lambda.zip && zip -r lambda.zip ./*)
#aws lambda update-function-code --endpoint-url http://localhost:4566 --function-name GetTransactionsByUserLambda --zip-file fileb://lambda-get-transactions-by-user/lambda.zip
echo "lambda-get-transactions-by-user updated"