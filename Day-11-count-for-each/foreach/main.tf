
variable "env" {
    type = list(string)
    default = ["dev", "prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.micro"
    for_each = toset(var.env) # toset not folows any order like list (index)
    tags = {
        Name = each.value
    }
}