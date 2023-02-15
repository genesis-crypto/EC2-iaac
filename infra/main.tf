module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.instance_name
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = "user"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.sg_ec2_3dol.id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}