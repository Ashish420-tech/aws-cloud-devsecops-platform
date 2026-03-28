terraform {
  backend "s3" {
    bucket         = "devsecops-terraform-state-ashish"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
