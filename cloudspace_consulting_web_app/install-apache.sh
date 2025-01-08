#!/bin/bash

# Update all yum package repositories
yum update -y

# Install Apache Web Server
yum install -y httpd.x86_64

# Start and Enable Apache Web Server
systemctl start httpd.service
systemctl enable httpd.service

# Install epel for easy access to commonly used packages
amazon-linux-extras install epel -y

# Install stress tool for testing EC2 Instance under stress workloads
yum install stress -y

# Add custom webpage HTML code to "index.html" file
echo "<html><body><h1>Welcome to Cloudspace Consulting!</h1></body></html>" > /var/www/html/index.html

# Install SSM Agent (for AWS Systems Manager)
yum install -y amazon-ssm-agent

# Enable and Start SSM Agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent