resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "ec2_s3_access_role"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_iam_policy" "ec2_s3_access_policy" {
  name        = "ec2_s3_access_policy"
  description = "Policy to allow EC2 instances to access S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::YOUR_S3_BUCKET_NAME",
          "arn:aws:s3:::YOUR_S3_BUCKET_NAME/*"
        ]
      }
    ]
  })

  tags = {
    Name = "ec2_s3_access_policy"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_s3_access_attach" {
  role       = aws_iam_role.ec2_s3_access.name
  policy_arn = aws_iam_policy.ec2_s3_access_policy.arn
}
resource "aws_iam_instance_profile" "ec2_s3_access_instance_profile" {
  name = "ec2_s3_access_instance_profile"
  role = aws_iam_role.ec2_s3_access.name

  tags = {
    Name = "ec2_s3_access_instance_profile"
    env  = "dev"
    team = "config management"
  }
}