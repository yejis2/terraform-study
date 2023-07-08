terraform {
  backend "s3" {
    bucket = "mybucket-tftest"
    key    = "tftest/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-locks"
  }
}