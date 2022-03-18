# Cloud Banking

[![Project Status](https://img.shields.io/static/v1?label=project%20status&message=in%20development&color=yellow&style=flat-square)](#)

Proof of concept to present some services provided by AWS.

> Amazon Web Services (AWS) is a cloud service provider that offers IT infrastructure services to companies, which is popularly known as cloud computing. 
In theory, it allows you to reduce infrastructure costs and speed up the acquisition of hardware.

Features:
- Save transaction
- Get transactions by user

Documentation:
- [dynamodb](docs/dynamodb)

Covered Services:
- [cloudformation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
- [sns](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
- [sqs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)
- [apigateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
- [lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [dynamodb](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

## Requirements

[![docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

## Installation

```bash
$ docker-compose up -d
```
    
## Usage

```bash
# save transaction
$ aws sns publish --endpoint-url http://localhost:4566 --topic-arn "arn:aws:sns:us-east-1:000000000000:SaveTransactionTopic" --message '{"user":"john","amount":"999.99","type":"TRANSFER_SENT"}'

# get rest_api_id
$ rest_api_id=`aws apigateway get-rest-apis --endpoint-url http://localhost:4566 | jq -r '.items[]|select(.name == "get-transactions-api")|.id'`

# check saved transactions
$ curl http://${rest_api_id}.execute-api.localhost.localstack.cloud:4566/dev/transactions?user=john
```

## Tech Stack

[![docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![python](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue)](https://www.python.org/)
[![aws](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)

## Reference

- https://aws.amazon.com/what-is-aws/
- https://docs.aws.amazon.com/index.html

## Feedback

If you have any feedback, please contact me at raphaeldias.ti@gmail.com

[![github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/raphaelbh)
[![linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/raphaelbh/)