resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.tetris_cluster.name
  addon_name   = "vpc-cni"

  tags = {
    Name = "vpc-cni"
  }
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.tetris_cluster.name
  addon_name   = "coredns"

  tags = {
    Name = "coredns"
  }
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.tetris_cluster.name
  addon_name   = "kube-proxy"

  tags = {
    Name = "kube-proxy"
  }
}
