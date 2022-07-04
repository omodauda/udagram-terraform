terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
    ami = "ami-052efd3df9dad4825"
    associate_public_ip_address = true
    instance_type = "t2.micro"
    key_name = "tutorial"
    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install apache2 -y
                sudo systemctl start apache2
                sudo bash -c "echo Hello world > /var/www/html/index.html"
                EOF

    tags = {
      "Name" = "udapeople-server"
    }
}