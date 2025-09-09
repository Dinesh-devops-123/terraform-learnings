# semi-dynamic version
# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
# Datasource
data "aws_ec2_instance_type_offerings" "available_micro_instances_v2" {
  for_each = toset(["ap-south-1a","ap-south-1b","ap-south-1c"])  #convert list --> set
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
# Important Note: Once for_each is set, its attributes must be accessed on specific instances
output "available_micro_instance_types_v2-1" {
  description = "Set of AZs in ap-south-1 where t2.micro is supported."
  #value       = data.aws_ec2_instance_type_offerings.available_micro_instances.instance_types
  value =  toset([for t in data.aws_ec2_instance_type_offerings.available_micro_instances_v2: t.instance_types])
}

# Output-2
#  Create a Map with key as availability zone and value as Instance type supported
output "available_micro_instance_types_v2-2"{
    value = {for az, details in data.aws_ec2_instance_type_offerings.available_micro_instances_v2: az => details.instance_types}
}