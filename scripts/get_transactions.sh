#!/bin/sh

apis=`aws apigateway get-rest-apis --endpoint-url http://localhost:4566`
rest_api_id=$(echo ${apis} | jq '.items | .[] | .id') 
rest_api_id="${rest_api_id%\"}"
rest_api_id="${rest_api_id#\"}"

curl http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions?user=jonh
echo ""
echo "http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions?user=jonh"

