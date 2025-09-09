# Terraform Small Utility Project

## 📌 Step-01: Introduction  

### Current Problem  
We are not able to create EC2 Instances in all the subnets of our VPC which are spread across availability zones in a region.  

### Approach to a Solution  
We need a solution to check whether our desired EC2 Instance Type (example: `t3.micro`) is supported in a particular availability zone.  

👉 Simply: **Give me the AZ list in a region where my desired instance type is supported.**

### Why Utility Project?  
In Terraform, we should not try new things directly in a large code base.  
Instead, build small utility projects to test requirements and later integrate into main code.  

---

## 📌 Step-02: `c1-versions.tf`  
Hard-coded region (no variables in this utility project).  

```hcl
provider "aws" {
  region = "us-east-1"
}

📌 Step-03: c2-v1-get-instancetype-supported-per-az-in-a-region.tf
AWS CLI Equivalent

# aws ec2 describe-instance-type-offerings --profile account2 --location-type availability-zone --filters Name=instance-type,Values=t2.micro --region ap-south-1 --output table

# aws ec2 describe-instance-type-offerings \
  --location-type availability-zone \
  --filters Name=instance-type,Values=t3.micro \
  --region ap-south-1 --output table

## cmd to find availability zones

# aws ec2 describe-availability-zones --profile account2 --region ap-south-1 --query "AvailabilityZones[*].ZoneName" --output table

  Datasource
data "aws_ec2_instance_type_offerings" "available_micro_instances" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = ["us-east-1a"]
  }
  location_type = "availability-zone"
}

Output
output "output_v1_1" {
  description = "The list of available t2.micro and t3.micro instance types in the specified region."
  value       = data.aws_ec2_instance_type_offerings.available_micro_instances.instance_types
}

Observation

For us-east-1a:
output_v1_1 = toset(["t3.micro"])


For us-east-1e:
output_v1_1 = toset([])
📌 Step-04: c2-v2-get-instancetype-supported-per-az-in-a-region.tf
Datasource with for_each
data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset(["us-east-1a", "us-east-1e"])
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

Outputs
# 1. Set of instance types per AZ
output "output_v2_1" {
  value = toset([
    for t in data.aws_ec2_instance_type_offerings.my_ins_type2 : t.instance_types
  ])
}

# 2. Map: AZ → instance type
output "output_v2_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2 :
    az => details.instance_types
  }
}

Observation
output_v2_1 = toset([
  toset(["t3.micro"]),
  toset([]),
])
output_v2_2 = {
  "us-east-1a" = toset(["t3.micro"])
  "us-east-1e" = toset([])
}

📌 Step-05: c2-v3-get-instancetype-supported-per-az-in-a-region.tf
Datasource for Availability Zones
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

Datasource with Dynamic for_each
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.my_azones.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

Outputs
# 1. All AZs mapped to supported instance types
output "output_v3_1" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
    az => details.instance_types }
}

# 2. Filter out unsupported AZs
output "output_v3_2" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
    az => details.instance_types if length(details.instance_types) != 0 }
}

# 3. Get only supported AZ names
output "output_v3_3" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
    az => details.instance_types if length(details.instance_types) != 0 })
}

# 4. Example: Get first supported AZ
output "output_v3_4" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
    az => details.instance_types if length(details.instance_types) != 0 })[0]
}

Sample Output
output_v3_1 = {
  "us-east-1a" = toset(["t3.micro"])
  "us-east-1b" = toset(["t3.micro"])
  "us-east-1c" = toset(["t3.micro"])
  "us-east-1d" = toset(["t3.micro"])
  "us-east-1e" = toset([])
  "us-east-1f" = toset(["t3.micro"])
}

output_v3_2 = {
  "us-east-1a" = toset(["t3.micro"])
  "us-east-1b" = toset(["t3.micro"])
  "us-east-1c" = toset(["t3.micro"])
  "us-east-1d" = toset(["t3.micro"])
  "us-east-1f" = toset(["t3.micro"])
}

output_v3_3 = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
  "us-east-1d",
  "us-east-1f",
]

output_v3_4 = "us-east-1a"

📌 Step-06: Clean-Up
terraform destroy -auto-approve
rm -rf .terraform* terraform.tfstate*