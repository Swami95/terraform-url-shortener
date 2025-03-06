variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for storing URLs"
  type        = string
}

# Uncomment if using S3 deployment
# variable "lambda_s3_bucket" {
#   description = "S3 bucket where Lambda code is stored"
#   type        = string
# }
#
# variable "lambda_s3_key" {
#   description = "S3 object key for Lambda deployment package"
#   type        = string
# }

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  default     = "devops-cloud"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID for resource references"
}


variable "use_s3" {
  type    = bool
  default = false
}

variable "lambda_s3_bucket" {
  type    = string
  default = ""
}

variable "lambda_s3_key" {
  type    = string
  default = ""
}

variable "lambda_s3_object_version" {
  type    = string
  default = ""
}
