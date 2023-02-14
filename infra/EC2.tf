provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_3dol" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.nano"
  key_name      = "my_key_pair"

  tags = {
    Name = "ec2_3dol"
  }  
  vpc_security_group_ids = [aws_security_group.sg_ec2_3dol.id]
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./path/to/my_key_pair.pem")
    host        = self.public_ip
  }
  
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
