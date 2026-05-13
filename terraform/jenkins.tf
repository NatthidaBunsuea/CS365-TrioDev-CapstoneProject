resource "aws_instance" "jenkins" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.medium"
  key_name      = "trio-dev-key"

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "jenkins-server"
  }
}