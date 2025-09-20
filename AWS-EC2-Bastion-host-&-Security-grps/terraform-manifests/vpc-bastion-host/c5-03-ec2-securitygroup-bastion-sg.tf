# AWS ec2 security group terraform module
# security group for public bastion host


module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${local.name}-public-bastion-sg"
  description = "security group for SSH port open for everybody(IPv4 CIDR),with egress ports are open for all world"
  vpc_id      = module.vpc.vpc_id

  # Ingress Rules & CIDR blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rules - allow all
  egress_rules = ["all-all"]
  tags = locals.common_tags
}
