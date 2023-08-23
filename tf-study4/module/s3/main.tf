resource "aws_s3_bucket" "s3" {
  bucket = join("-", ["${local.project_name}", "${local.s3_name}", "${local.env}"])

  tags = {
  }
}

# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.s3.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

