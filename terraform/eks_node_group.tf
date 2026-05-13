resource "aws_eks_node_group" "tetris_nodes" {
  cluster_name    = aws_eks_cluster.tetris_cluster.name
  node_group_name = "tetris-node-group"
  node_role_arn   = "arn:aws:iam::568917083422:role/c197601a5059488l14052371t1w568917083-LabEksNodeRole-8Uazsg5VyQLB"

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = "trio-dev-key"
    source_security_group_ids = [aws_security_group.eks_node_sg.id]
  }

  tags = {
    Name = "tetris-node-group"
  }
}
