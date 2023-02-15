terraform {
  backend "s3" {
    bucket = "terraform-state-e2-3dol"
    key    = "terraform-ec2.tfstate"
    region = "us-east-1"
  }
}
