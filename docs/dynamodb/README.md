# Dynamodb

## Data Access Patterns
- Get transactions by user 

## Structure
```
Transaction: {
  user: string (partition key)
  transaction_id: string (sort key)
  date_time: decimal
  amount: decimal
  type: string { TRANSFER_SENT, TRANSFER_RECEIVED, PURCHASE, PAYMENT, CANCELLED }
}
```

## Reference
- https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html