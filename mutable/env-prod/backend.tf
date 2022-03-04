terraform {
  backend "s3" {
    bucket = "terraform-b62"
    key    = "mutable/user/prod/terraform.tfstate"
    region = "us-east-1"
  }
}
