resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = ""
}

resource "aws_default_vpc" "default" {
}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mainvpc.id

  ingress{
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh open"
  }

  ingress{
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS open"
  }

  ingress{
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  ingress{
    from_port = 465
    to_port = 465
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SMTPS open"
  }


  ingress{
    from_port = 3000 - 10000
    to_port = 3000 - 10000
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "custom open"
  }


  ingress{
    from_port = 25
    to_port = 25
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SMTP open"
  }


  ingress{
    from_port = 6443
    to_port = 6443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "custom open"
  }

ingress{
    from_port = 6379
    to_port = 6379
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "custom open"
  }

  ingress{
    from_port = 30000 - 32767
    to_port = 30000 - 32767
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "custom open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "mysecurity"
  }
}

resource "aws_instance" "testinstance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_user_to_connect.name]
  tags = {
    Name = "Automate"
  }
  root_block_device {
    volume_size = 30 
    volume_type = "gp3"
  }
}