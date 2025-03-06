# Create API Gateway
resource "aws_api_gateway_rest_api" "url_shortener_api" {
  name        = "URL Shortener API"
  description = "API for URL shortening"
}

# Create API Gateway Resource for /shorten
resource "aws_api_gateway_resource" "shorten_url" {
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  parent_id   = aws_api_gateway_rest_api.url_shortener_api.root_resource_id
  path_part   = "shorten"
}

# Create API Gateway Method for POST /shorten
resource "aws_api_gateway_method" "shorten_url_post" {
  rest_api_id   = aws_api_gateway_rest_api.url_shortener_api.id
  resource_id   = aws_api_gateway_resource.shorten_url.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integrate API Gateway with Lambda
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id
  resource_id = aws_api_gateway_resource.shorten_url.id
  http_method = aws_api_gateway_method.shorten_url_post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri  = var.lambda_invoke_arn
}

# Deploy API Gateway
resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.url_shortener_api.id

  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create API Gateway Stage
resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.url_shortener_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}

# Give Lambda permissions to be invoked by API Gateway
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.url_shortener_api.execution_arn}/*/*"
}
