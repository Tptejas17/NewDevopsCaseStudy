provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH access from anywhere"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "app_server" {
  ami                    = "ami-03bb6d83c60fc5f7c"  # Ubuntu 22.04 in Mumbai
  instance_type          = "t2.micro"
  key_name               = "devops-server-keypair"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  provisioner "remote-exec" {
    inline = ["echo Instance is ready"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/devops-server-key.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "CaseStudyAppInstance"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}

