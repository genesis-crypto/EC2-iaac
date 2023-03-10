resource "local_file" "server_ec2_3dol_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/../ansible/ec2_3dol.pem"
  file_permission = "0600"
}

resource "local_file" "ansible_hosts" {
  filename = "${path.module}/../ansible/hosts"
  content  = <<EOF
  [ec2]
  ${aws_eip.ec2_eip.public_ip}

  [ec2:vars]
  ansible_private_key_file=./ec2_3dol.pem
  ansible_user=ubuntu
  EOF
}

output "path_module" {
  value       = "${path.module}"
}

