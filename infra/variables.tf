variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "private_key_path" {
  type    = string
  default = "/usr/my_key.pem"
}

variable "instance_type" {
  type    = string
  default = "t4g.nano"
  description = "The instance type from the EC2 machine"
}

variable "instance_name" {
  type    = string
  default = "ec2_3dol"
  description = "The instance name from the EC2 machine"
}
