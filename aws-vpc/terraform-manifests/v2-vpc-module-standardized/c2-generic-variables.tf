# Input Variable
# AWS Region
variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "ap-south-1"
  
}

# Environment Variable
variable "environment" {
    description = "Environment Variable used in prefix"
    type = string
    default = "dev"
}

# Business Division 
variable "business_division" {
  description = "Business division in the large organization this infrastructure belongs "
  type = string
  default = "SAP"
}