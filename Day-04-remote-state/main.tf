
resource "aws_instance" "pp" {
  ami = "ami-0b46816ffa1234887"
  instance_type = "t3.micro"
  tags = {
    Name = "Patidar"
  }
}
resource "aws_s3_bucket" "name" {
  bucket = "dheerajprodtest"
}