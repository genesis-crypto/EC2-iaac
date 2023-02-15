terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "terraform-ec2.tfstate"
    region = "us-east-1"
  }
}
