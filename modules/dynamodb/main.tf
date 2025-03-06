resource "aws_dynamodb_table" "url_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "short_url"
    type = "S"
  }

  attribute {
    name = "original_url"
    type = "S"
  }

  hash_key  = "short_url"  # Primary key
  range_key = "original_url" # Optional: If you need a composite key

  global_secondary_index {
    name            = "OriginalUrlIndex"
    hash_key        = "original_url"
    projection_type = "ALL"
  }
}
