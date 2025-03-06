output "lambda_function_name" {
  value = aws_lambda_function.url_shortener.function_name
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.url_shortener.invoke_arn
}
