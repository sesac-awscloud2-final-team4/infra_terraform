provider "aws" {
  region = "ap-southeast-7"
  profile = "sesac"

}

resource "aws_s3_bucket" "terraform-tfstate-version-management" {
  bucket = "terraform-tfstate-version-management"
}

# Enable versioning so you can see the full revision history of your state files
resource "aws_s3_bucket_versioning" "terraform_versioning" {
  bucket = aws_s3_bucket.terraform-tfstate-version-management.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-tfstate-version-dbtable" {
  name         = "terraform-version-dbtable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform-tfstate-version-management.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform-tfstate-version-dbtable.name
  description = "The name of the DynamoDB table"
}