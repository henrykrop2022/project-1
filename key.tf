resource "tls_private_key" "utc_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "utc_key_pem" {
  content  = tls_private_key.utc_key.private_key_pem
  filename = "${path.module}/utc-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "utc_key" {
  key_name   = "utc-key"
  public_key = tls_private_key.utc_key.public_key_openssh
  
  tags = {
    env  = "dev"
    team = "config management"
  }
}