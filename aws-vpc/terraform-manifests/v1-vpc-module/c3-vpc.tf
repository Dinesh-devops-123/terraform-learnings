# Create VPC Terraform Module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  # vpc basics details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database subnets 
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"] 
#   create_database_nat_gateway_route = true   → allows DB subnets to access the internet *outbound* via NAT Gateway, while still remaining private
#   create_database_internet_gateway_route = true → makes DB subnets public by routing them directly to the Internet Gateway
   
   # NAT gateways - outbound communication
   enable_nat_gateway = true
   single_nat_gateway = true

   # VPC DNS Parameter
   enable_dns_hostnames = true
   enable_dns_support = true

   public_subnet_tags = {
    Name = "Public_subnet"
   }

   private_subnet_tags = {
    Name = "Private_subnet"
   }

   tags = { #(argument open =)
    Owner = "dinesh"
    Environment = "dev"
   }

   vpc_tags = {
    Name = "vpc-dev"
   }

}