
resource "aws_instance" "name" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    tags = {
      Name = "dev"
    }
   
}

resource "aws_s3_bucket" "name" {
    bucket = "nareshit-devops-dev"
  
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
}

#example s3 import command 
#terraform import aws_s3_bucket.name "bucket name"
