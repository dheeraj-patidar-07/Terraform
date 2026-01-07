module "Dev" {
  source = "../Day-08-modules"
  ami_id = "ami-0b46816ffa1234887"
  type = "t3.micro"
}