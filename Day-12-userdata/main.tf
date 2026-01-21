
provider "aws" {
  
}
resource "aws_instance" "server" {
  ami                         = "ami-0261755bbcb8c4a84" # Ubuntu AMI
  instance_type               = "t2.micro"
  user_data = file("test.sh")

  tags = {
    Name = "UbuntuServer"
  }
}