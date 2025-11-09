resource "aws_iam_role" "terraform_admin" {
  name = "TerraformAdmin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach basic SSM access
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.terraform_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create the instance profile
resource "aws_iam_instance_profile" "terraform_admin" {
  name = "TerraformAdmin"
  role = aws_iam_role.terraform_admin.name
}
