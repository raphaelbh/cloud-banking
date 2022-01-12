#!/bin/sh

if [ $# -lt 1 ];
then
    echo "Sorry, please inform the lambda name (SaveTransactionLambda or GetTransactionsByUserLambda)"
    exit
fi

lambda_name=$1
lambda_directory=""

if [ "$lambda_name" = "GetTransactionsByUserLambda" ];
then
    lambda_directory="lambda-get-transactions-by-user"

elif [ "$lambda_name" = "SaveTransactionLambda" ];
then
    lambda_directory="lambda-save-transaction"

else
    echo "Sorry, please inform the lambda name (SaveTransactionLambda or GetTransactionsByUserLambda)"
    exit
fi

# update lambda function
(cd ${lambda_directory} && rm -f -r -- __pycache__ && rm -f -- lambda.zip && zip -r lambda.zip ./*)
aws lambda update-function-code --endpoint-url http://localhost:4566 --function-name ${lambda_name} --zip-file fileb://${lambda_directory}/lambda.zip
(cd ${lambda_directory} && rm -f -- lambda.zip)