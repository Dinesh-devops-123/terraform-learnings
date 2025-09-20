# AWS EC2 Instance terraform module
# Bastion Host - EC2 Instance that will be created in VPC public subnet

module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1" #locks specific version

  name         = "${local.name}-BastionHost"
  ami           = data.aws_ami.ubuntu_os.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring    = true
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  subnet_id     = module.vpc.public_subnets[0] #create EC2 on public subnet 1
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}