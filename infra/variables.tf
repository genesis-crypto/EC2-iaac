variable "private_key_path" {
  type    = string
  default = "/usr/my_key.pem"
}

variable "instance_type" {
  type    = string
  default = "t3.nano"
  description = "The instance type from the EC2 machine"
}

variable "instance_name" {
  type    = string
  default = "ec2_3dol"
  description = "The instance name from the EC2 machine"
}
