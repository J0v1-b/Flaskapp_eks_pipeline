provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

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

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = ["subnet-01234567890abcdef0", "subnet-01234567890abcdef1"]
    security_group_ids = ["sg-01234567890abcdef0"]
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example"
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }
}

