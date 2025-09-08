# Terraform output values 

# EC2 Instance Public IP with TOSET
output "instance_publicip" {
    description = "EC2 Instance Public IP"
    #value = aws_instance.myec2.*.public_ip # legacy splat
    #value = aws_instance.myec2[*].public_ip #latest splat
    value = [for instance in aws_instance.myec2: instance.public_ip]
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
    description = "EC2 Instance Public DNS"
    #value = aws_instance.myec2[*].public_dns # legacy splat
    #value = aws_instance.myec2[*].public_dns #latest splat
    value = [for instance in aws_instance.myec2: instance.public_dns]
      
}

# EC2 Instance Public DNS with TOMAP
output "instance_publicdns2" {
    description = "EC2 Instance Public DNS"
    value  = tomap({for az, instance in aws_instance.myec2: az => instance.public_dns})
  
}