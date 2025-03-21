resource "aws_instance" "bastion_host" {
  ami           = "ami-04aa00acb1165b32a" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.utc_key.key_name
  subnet_id     = aws_subnet.public_subnet_1a.id
  security_groups = [aws_security_group.bastion_host_sg.id]
   associate_public_ip_address = true
  
  tags = {
    Name = "Bastion Host"
    env  = "dev"
    team = "config management"
  }

  provisioner "file" {
    source      = "${local_file.utc_key_pem.filename}"
    destination = "/home/ec2-user/utc-key.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.utc_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/utc-key.pem"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.utc_key.private_key_pem
      host        = self.public_ip
    }
  }
  depends_on = [aws_internet_gateway.utc_igw]
}