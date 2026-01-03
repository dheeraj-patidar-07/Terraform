terraform {
  backend "s3" {
    bucket = "dheerajprodtest"
    key    = "terraform.tfstate"
    region = "eu-north-1"
    # Enable S3 native locking
     #use_lockfile = true 
    # The dynamodb_table argument is no longer needed

    dynamodb_table = "dheerajtest"

  }
}