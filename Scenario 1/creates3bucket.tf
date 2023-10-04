# terraform script to create S3 bucket
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "front_end_bucket" {
  bucket = "unique-bucket-name"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.front_end_bucket.bucket
}