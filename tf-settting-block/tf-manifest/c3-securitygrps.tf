# Create Security Group - SSH Traffic 
resource "aws_security_group" "vpc-ssh" {
    name  = "vpc-ssh"
    description = "Dev VPC SSh"
    #vpc_id  = "aws_vpc.main.id"

    ingress {
        description = "Allow port 22"
        from_port = 22
        to_port  = 22
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }

    egress {
        description = "Allow all ip and ports outbound"
        from_port = 0
        to_port = 0
        protocol = "-1" #allow all IP-based protocols (TCP, UDP, ICMP, etc.)
        cidr_blocks = "0.0.0.0/0" #IPV4
        #ipv6_cidr_blocks = ["::/0"] IPV6
    }

    tags = {
      Name = "vpc-ssh"
    }
}

# Create Security Group - Web Traffic 