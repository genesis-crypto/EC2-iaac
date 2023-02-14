resource "aws_instance" "ec2_3dol" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  vpc_security_group_ids = [aws_security_group.sg_ec2_3dol.id]
  
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install nginx1.12",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo cat <<EOF > /etc/nginx/conf.d/node-api.conf",
      "server {",
      "  listen 80;",
      "  server_name localhost;",
      "  location / {",
      "    proxy_pass http://localhost:3000;",
      "    proxy_http_version 1.1;",
      "    proxy_set_header Upgrade $http_upgrade;",
      "    proxy_set_header Connection 'upgrade';",
      "    proxy_set_header Host $host;",
      "    proxy_cache_bypass $http_upgrade;",
      "  }",
      "}",
      "EOF",
      "sudo systemctl reload nginx"
    ]
  }
}

resource "aws_security_group" "sg_ec2_3dol" {
  name_prefix = "example"
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
