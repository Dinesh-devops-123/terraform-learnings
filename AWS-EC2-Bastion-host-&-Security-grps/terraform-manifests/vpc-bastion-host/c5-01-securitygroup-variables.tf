# AWS EC2 Instance Terraform Variables

# AWS EC2 Instance type

variable "instance_type" {
    description = "EC2 Instance type"
    type = string
    default = "t3.micro"
}

# AWS EC2 Instance key pair
variable "instance key pair" {
    description = "AWS EC2 key pair that need to be associated with EC2 Instance"
    type = string
    default = "training-instance.pem"
  
}