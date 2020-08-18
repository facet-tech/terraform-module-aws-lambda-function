{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ec2:CreateTags",
        "ec2:DescribeTags",
        "ec2:DeleteTags",
        "ec2:list*",
        "ec2:describe*",
        "ec2:get*",
        "sqs:*",
        "secretsmanager:GetSecretValue",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:UpdateItem",
        "dynamodb:GetRecords",
        "kms:GetPublicKey",
        "kms:Decrypt",
        "kms:GenerateDataKey",
        "lambda:InvokeFunction"
      ],
      "Resource": "*"
    }
  ]
}