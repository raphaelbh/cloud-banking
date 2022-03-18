# Lambda Get Transactions

Lambda used to get user's transactions.

## Requirements

[![docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)


## Local Development

```bash
# create alias to run lambda container
$ alias lambda="docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/lambda:/lambda --net=host raphaelbh/lambda"

# invoke lambda 
$ lambda invoke $(cat events/event.json | tr -d " \t\n\r")

# update lambda code on localstack
$ lambda update-code GetTransactionsByUserLambda
```

## Environment Variables
`AWS_ACCESS_KEY`

`AWS_ACCESS_SECRET_KEY`

`AWS_REGION`

`DYNAMODB_ENDPOINT_URL`


## Feedback

If you have any feedback, please contact me at raphaeldias.ti@gmail.com

[![github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/raphaelbh)
[![linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/raphaelbh/)