terraform {
  backend "s3" {
    bucket         = "sock-bucket-seyi"
    key            = "terraform/stateseyi"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-seyi"
  }
}
