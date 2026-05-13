output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.tetris_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.tetris_cluster.endpoint
}

output "eks_cluster_version" {
  value = aws_eks_cluster.tetris_cluster.version
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.tetris_cluster.name}"
}
