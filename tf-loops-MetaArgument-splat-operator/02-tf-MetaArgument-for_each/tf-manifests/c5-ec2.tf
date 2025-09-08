# Availability Zones DataSource
data "aws_availability_zones" "my_azones" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# EC2 Instance
resource "aws_instance" "myec2" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = var.instance_type_list[1]
  #instance_type          = var.instance_type_map["dev"] #map string 
  user_data              = file("${path.module}/app1-install.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id ]
  # Create EC2 Instance in all availabilty Zones of a VPC
  for_each = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key # We can also use each.value because for list items each.key == each.value
  tags = {
     "Name" = "for_each-Demo-${each.value}"
  }
}



/*
# Drawbacks of using count in this example
- Resource Instances in this case were identified using index numbers 
instead of string values like actual subnet_id
- If an element was removed from the middle of the list, 
every instance after that element would see its subnet_id value 
change, resulting in more remote object changes than intended. 
- Even the subnet_ids should be pre-defined or we need to get them again 
using for_each or for using various datasources
- Using for_each gives the same flexibility without the extra churn.
*/