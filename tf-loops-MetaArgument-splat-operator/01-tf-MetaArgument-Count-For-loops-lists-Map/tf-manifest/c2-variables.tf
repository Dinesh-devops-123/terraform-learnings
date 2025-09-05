# Input Region
# AWS Region
variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "ap-south-1"  
}

# EC2 Instance type
variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.micro"  
}

# Key pair
variable "instance_keypair" {
    description = "AWS EC2 key-Pair that need to be associated with EC2 Instance"
    type = string 
    default = "training-instance"  
}

# AWS EC2 Instance type - list
variable "instance_type_list" {
    description = "EC2 instance type list"
    type = list(string)
    default = [ "t2.micro", "t2.small", "t2.medium" ]
} 

# AWS EC2 Instance type - Map 
variable "instance_type_map" {
    description = "EC2 instance type map"
    type = map(string)
    default = {
      "dev" = "t2.micro"
      "Qa"  = "t2.small"
      "prod" = "t2.medium"
    }  
}