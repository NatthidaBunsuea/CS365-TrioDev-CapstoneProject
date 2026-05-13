resource "aws_eks_cluster" "tetris_cluster" {
  name     = "Tetris-EKS-Cluster"
  role_arn = "arn:aws:iam::568917083422:role/c197601a5059488l14052371t1w568917-LabEksClusterRole-NA7KTY8selJ8"
  version  = "1.35"

  bootstrap_self_managed_addons = false

  compute_config {
    enabled = false
  }

  storage_config {
    block_storage {
      enabled = false
    }
  }

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id,
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id,
    ]
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  tags = {
    Name = "Tetris-EKS-Cluster"
  }
}
