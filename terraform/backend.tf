terraform {
  backend "s3" {
    bucket = "generic-terraform-backend"
    key = "production.tfstate"
    region = "eu-central-1"
  }
}
