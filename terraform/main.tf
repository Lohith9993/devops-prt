provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "k8s_sg" {
  name = "k8s-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "k8s_control_plane" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.medium"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  tags = {
    Name = "k8s-control-plane"
  }
}

resource "aws_instance" "k8s_worker_1" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.medium"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  tags = {
    Name = "k8s-worker-1"
  }
}

output "control_plane_ip" {
  value = aws_instance.k8s_control_plane.public_ip
}

output "worker_ip" {
  value = aws_instance.k8s_worker_1.public_ip
}
