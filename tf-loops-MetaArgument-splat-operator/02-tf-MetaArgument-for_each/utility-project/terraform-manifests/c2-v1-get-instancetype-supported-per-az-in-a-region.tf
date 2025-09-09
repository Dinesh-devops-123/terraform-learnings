# Data source
# check particular instance type is available in those region
# base version check not dynamic

data "aws_ec2_instance_type_offerings" "available_micro_instances_v1" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = ["ap-south-1"]
    # values = ["ap-south-1c"] 
  }

  location_type = "availability-zone"
}

# Output
output "available_micro_instance_types_v1-1" {
description = "The list of available t2.micro and t3.micro instance types in the specified region."
value       = data.aws_ec2_instance_type_offerings.available_micro_instances_v1.instance_types
}