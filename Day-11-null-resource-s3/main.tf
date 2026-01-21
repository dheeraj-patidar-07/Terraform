resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-demo-bucket-123"
}

resource "null_resource" "upload" {
  depends_on = [aws_s3_bucket.bucket]

  provisioner "local-exec" {
    command = "aws s3 cp file.txt s3://${aws_s3_bucket.bucket.bucket}/file.txt"
  }
}