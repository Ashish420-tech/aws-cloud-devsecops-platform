data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

provider "aws" {
  region = "ap-south-1"
}

# 🔐 Key Pair (use your existing key name)
variable "key_name" {
  default = "jenkins-key"
}

# 🔒 Security Group
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sonar-sg"
  description = "Allow Jenkins & SonarQube"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🐳 IAM Role for EC2 (ECR access)
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

# 📦 ECR Repo
resource "aws_ecr_repository" "app_repo" {
  name = "devsecops-app"
}

# 💻 EC2 Instance
resource "aws_instance" "jenkins_server" {
  associate_public_ip_address = true
  ami           = "ami-0f5ee92e2d63afc18" # Ubuntu 22.04 (ap-south-1)
  instance_type = "m7i-flex.large"
  key_name      = var.key_name

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y

              # Java
              apt install openjdk-17-jre -y

              # Jenkins
              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
              /usr/share/keyrings/jenkins-keyring.asc > /dev/null

              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
              https://pkg.jenkins.io/debian binary/ | tee \
              /etc/apt/sources.list.d/jenkins.list > /dev/null

              apt update -y
              apt install jenkins -y
              systemctl start jenkins
              systemctl enable jenkins

              # Docker
              apt install docker.io -y
              usermod -aG docker ubuntu
              usermod -aG docker jenkins

              # AWS CLI
              apt install awscli -y

              # Maven
              apt install maven -y

              # SonarQube Setup
              apt install unzip -y
              useradd sonar

              cd /opt
              wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
              unzip sonarqube-9.4.0.54424.zip
              mv sonarqube-9.4.0.54424 sonarqube
              chown -R sonar:sonar /opt/sonarqube

              # Start SonarQube
              su - sonar -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"
              EOF

  tags = {
    Name = "Jenkins-Sonar-Server"
  }
}

# 📤 Outputs
output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "sonarqube_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:9000"
}

output "ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}
