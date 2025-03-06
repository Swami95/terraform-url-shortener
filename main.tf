module "dynamodb" {
  source              = "./modules/dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  dynamodb_table_name  = module.dynamodb.dynamodb_table_name
}

module "api_gateway" {
  source               = "./modules/api_gateway"
  lambda_function_name = module.lambda.lambda_function_name
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
}

