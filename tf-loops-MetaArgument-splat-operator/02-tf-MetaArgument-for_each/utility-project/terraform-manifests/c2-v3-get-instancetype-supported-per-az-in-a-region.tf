# Get List of Availability Zones in a Specific Region
# Region is set in c1-versions.tf in Provider Block
# Datasource-1
data "aws_availability_zones" "my_zones"{
    filter {
      name = "opt-in-status"
      values = ["opt-in-not-required"]
    }

}

# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
# Datasource-2
data "aws_ec2_instance_type_offerings" "available_micro_instances_v3" {
  for_each = toset(data.aws_availability_zones.my_zones.names)  
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
    # values = ["ap-south-1c"] 
  }

  location_type = "availability-zone"
}


# Output-1
# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_v3-1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.available_micro_instances_v3: az => details.instance_types
  }
}

# Output-2
# Filtered Output: Exclude Unsupported Availability Zones
output "output_v3-2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.available_micro_instances_v3: 
    az => details.instance_types if length(details.instance_types) != 0 }
}

# Output-3
# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v3-3" {
    value = keys({ #list only the keys
     for az, details in data.aws_ec2_instance_type_offerings.available_micro_instances_v3: 
     az => details.instance_types if length(details.instance_types) != 0 })
}


# Output-4 (additional learning)
# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3-4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.available_micro_instances_v3: 
    az => details.instance_types if length(details.instance_types) != 0 })[0]
}

