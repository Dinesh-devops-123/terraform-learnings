# Resource : EC2 instance
resource "aws_instance" "myec2vm" {
  provider = aws.training
  ami           = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
  key_name      = "training-instance"
  user_data     = file("${path.module}/app1-install.sh")

  tags = {
    Name = "demo-EC2"
  }
}


