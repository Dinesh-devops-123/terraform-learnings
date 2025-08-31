#! /bin/bash
# Update and install Apache (Ubuntu package = apache2)
apt update -y
apt install -y apache2

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Create main home page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
  <head>
    <title>Terraform Playground</title>
  </head>
  <body style="background-color:lightblue;">
    <h1>Welcome to Terraform Practice</h1>
    <h2>Dinesh - Terraform Playground</h2>
  </body>
</html>
EOF

# Create a subfolder for extra pages
mkdir -p /var/www/html/app1

# Create an additional app1 page
cat <<EOF > /var/www/html/app1/index.html
<!DOCTYPE html>
<html>
  <head>
    <title>Dinesh Terraform Playground</title>
  </head>
  <body style="background-color:lavender;">
    <h1>Welcome to Terraform Practice</h1>
    <p>Dinesh - Terraform Playground</p>
    <p>Application Version: V1</p>
  </body>
</html>
EOF

# Fetch EC2 metadata securely (IMDSv2) and save as metadata.html
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/dynamic/instance-identity/document \
  -o /var/www/html/app1/metadata.html
