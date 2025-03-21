resource "aws_instance" "app_server_1a_1" {
  ami           = "ami-04aa00acb1165b32a" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.utc_key.key_name
  subnet_id     = aws_subnet.private_subnet_1a.id
  security_groups = [aws_security_group.app_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "appserver-1a-1"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_instance" "app_server_1a_2" {
  ami           = "ami-04aa00acb1165b32a" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.utc_key.key_name
  subnet_id     = aws_subnet.private_subnet_1a.id
  security_groups = [aws_security_group.app_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "appserver-1a-2"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_instance" "app_server_1b_1" {
  ami           = "ami-04aa00acb1165b32a" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.utc_key.key_name
  subnet_id     = aws_subnet.private_subnet_1b.id
  security_groups = [aws_security_group.app_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "appserver-1b-1"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_instance" "app_server_1b_2" {
  ami           = "ami-04aa00acb1165b32a" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.utc_key.key_name
  subnet_id     = aws_subnet.private_subnet_1b.id
  security_groups = [aws_security_group.app_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "appserver-1b-2"
    env  = "dev"
    team = "config management"
  }
}