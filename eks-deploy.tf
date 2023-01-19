provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

  # Define the assume role policy for the IAM role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eks_cluster_policy" {
  name = "eks_cluster_policy"
  role = aws_iam_role.eks_cluster_role.id

  # Define the policy for the IAM role
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:*",
        "cloudwatch:*",
        "ec2:*",
        "elasticloadbalancing:*",
        "iam:PassRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks_cluster_sg"
  description = "Security group for EKS cluster"

  # Define ingress rules for the security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.eks_cluster_role.arn

  # Define the VPC config for the EKS cluster
  vpc_config {
    subnet_ids = ["subnet-01234567890abcdef0", "subnet-01234567890abcdef1"]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example"
  
  # Define the scaling config for the EKS node group
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }
