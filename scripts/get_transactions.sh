#!/bin/sh

if [ $# -lt 1 ];
then
    echo "Sorry, please inform the user"
    exit
fi

user=$1
apis=`aws apigateway get-rest-apis --endpoint-url http://localhost:4566`
rest_api_id=$(echo ${apis} | jq '.items | .[] | .id') 
rest_api_id="${rest_api_id%\"}"
rest_api_id="${rest_api_id#\"}"

curl -s http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions?user=${user}
echo ""
echo "http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions?user=${user}"