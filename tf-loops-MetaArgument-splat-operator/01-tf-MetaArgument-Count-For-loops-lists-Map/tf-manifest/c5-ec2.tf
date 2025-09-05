# EC2 Instance

# EC2 Instance

resource "aws_instance" "myec2" {
  # provider = aws.training
  ami                    = data.aws_ami.ubuntu_2204.id
  # instance_type = var.instance_type
  # instance_type = var.instance_type_list[1] #list
  instance_type          = var.instance_type_map["prod"] #map string 
  user_data              = file("${path.module}/app1-install.sh")
  key_name               = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id ]
  count = 5
  tags = {
     Name = "EC2 Demo-2-${count.index}"
    #  Name = "EC2 Demo-2"
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