# Create a null resource and provisioners
resource "null_resource" "copy_ec2_key" {
  depends_on = [module.ec2_public]

  # connection block for provisioners to connect to EC2 instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ubuntu" # default for Ubuntu AMI
    private_key = file("AWS-EC2-Bastion-host-&-Security-grps/private-key/training-instance.pem")
  }

  # File provisioner: copies the training-instance.pem file to /tmp/training-instance.pem
  provisioner "file" {
    source      = "AWS-EC2-Bastion-host-&-Security-grps/private-key/training-instance.pem"
    destination = "/tmp/training-instance.pem"
  }
  # Remote exec provisioner: fix the private key permission on bastion-host
  provisioner "remote-exec" {
    inline = [ "sudo chmod 400 /tmp/training-instance.pem"]
  }
  # Local exec provisioner:(creation time provisioner)trigger during resource creation 
  provisioner "local-exec" {
    command = "echo vpc created on 'date' and vpc-ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt "
    working_dir = "local-exec-output-files/"
  }
}

