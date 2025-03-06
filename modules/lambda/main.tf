resource "aws_lambda_function" "url_shortener" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 15
  memory_size   = 512  # Increased memory for better performance

  # Conditional deployment: Local ZIP or S3
  filename         = var.use_s3 ? null : "${path.module}/lambda_function.zip"
  source_code_hash = var.use_s3 ? null : filebase64sha256("${path.module}/lambda_function.zip")
  s3_bucket        = var.use_s3 ? var.lambda_s3_bucket : null
  s3_key           = var.use_s3 ? var.lambda_s3_key : null
  s3_object_version = var.use_s3 ? (var.lambda_s3_object_version != "" ? var.lambda_s3_object_version : null) : null

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }

  # Ensure IAM role & policy are created before Lambda
  depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_role_policy_attachment.lambda_dynamodb_attachment
  ]
}

