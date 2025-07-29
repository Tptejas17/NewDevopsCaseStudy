provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "app_server" {
  ami                         = "ami-03f4878755434977f" # Ubuntu 22.04 in ap-south-1 (Mumbai)
  instance_type               = "t2.micro"
  key_name                    = "devops-server-keypair"
  associate_public_ip_address = true

  tags = {
    Name = "devops-nodejs-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "echo Hello from Terraform EC2!"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
    }
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}

