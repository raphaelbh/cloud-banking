#!/bin/sh

if [ $# -lt 3 ];
then
    echo "Sorry, please inform user, amount and transaction type"
    exit
fi

message="{'user':'$1','amount':'$2','type':'$3'}"
topic="arn:aws:sns:us-east-1:000000000000:SaveTransactionTopic"

aws sns publish --endpoint-url http://localhost:4566 --topic-arn ${topic} --message ${message}
echo "message ${message} published"