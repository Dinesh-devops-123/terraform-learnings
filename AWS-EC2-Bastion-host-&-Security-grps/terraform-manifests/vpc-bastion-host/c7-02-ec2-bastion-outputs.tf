# AWS EC2 instance terraform outputs
# Public EC2 instance - Bastion Host


# EC2 bastion public instance ids
output "ec2_bastion_instance_ids" {
   description = "List of IDs of instance"
   value = module.ec2_public.id
}
# EC2 Bastion public_ip
output "ec2_bastion_eip"{
    description = "Elastic IP associated to the bastion host"
    value = aws_eip.bastion_eip.public_ip
}