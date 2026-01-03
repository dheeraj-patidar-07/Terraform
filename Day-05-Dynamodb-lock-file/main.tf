resource "aws_instance" "pp" {
  ami = "ami-0b46816ffa1234887"
  instance_type = "t3.micro"
  tags = {
    Name = "patidar"
  }
}