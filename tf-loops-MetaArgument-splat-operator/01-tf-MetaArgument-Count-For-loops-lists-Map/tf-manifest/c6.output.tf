# Terraform output values 
# 1. For loop with list
# 2. for loop with map
# 3. for loop with map advanced
# 4. legacy splat operator - return list
# 5. latest generalized splat operator - return the list

# output - for loop with list
output "for_output_list" {
    description = "For Loop with List"
    #aws_instance.myec2 --where to get the I/P
    value = [for instance in aws_instance.myec2: instance.public_dns]
  
}
# output - for loop with map
# map -- Key : Value
output "for_output_map1"{
    description = "For loop with Map"
    value = {for instance in aws_instance.myec2: instance.id => instance.public_dns}
}

# output - for loop with map advanced
output "for_output_map2" {
    description = "For loop with Map-advanced"
    value = {for c, instance in aws_instance.myec2: c => instance.public_dns} 
}

# output legacy splat operator(legacy) - returns the list
output "legacy_splat_instance_publicdns"{
    description = "Legacy Splat Operator"
    value = aws_instance.myec2.*.public_dns
}

# output latest generalized splat operator - returns the list
output "latest_splat_instance_publicdns"{
    description = "Latest Splat Operator"
    value = aws_instance.myec2[*].public_dns
}

/*
# EC2 Instance Public IP
output "Instance_publicip" {
    description = "EC2 Instance Public IP"
    value = aws_instance.myec2.public_ip
}
# EC2 Instance Public DNS 
output "instance_publicdns" {
    description = "EC2 Instance Public DNS"
    value = aws_instance.myec2.public_dns
}
*/