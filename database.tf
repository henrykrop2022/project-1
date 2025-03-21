resource "aws_db_instance" "utc_dev_database" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.35"
  storage_type         = "gp2"
  instance_class       = "db.t3.micro"
 license_model        = "general-public-license"
  identifier           = "utc-dev-database"
  username             = "utcuser"
  password             = "utcdev12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  db_subnet_group_name = aws_db_subnet_group.utc_subnet_group.name

  tags = {
    Name = "utc-dev-database"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_db_subnet_group" "utc_subnet_group" {
  name       = "utc-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id
  ]

  tags = {
    Name = "utc-subnet-group"
    env  = "dev"
    team = "config management"
  }
}