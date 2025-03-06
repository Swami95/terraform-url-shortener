variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  default     = "devops-cloud"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  default     = "url-shortener"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  default     = "shortened-urls"
}