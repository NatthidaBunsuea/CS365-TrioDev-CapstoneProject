terraform {
  backend "s3" {
    bucket         = "triodev-terraform-state-123"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}