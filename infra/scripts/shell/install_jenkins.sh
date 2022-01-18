#!/bin/bash

# stop this script on first error
set -e
# Update the OS
sudo yum update -y
# Add repo config for Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
# Import Repo Keys
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# Install extras 
sudo amazon-linux-extras install epel -y
# Rerun the update
sudo yum update -y
# Upgrade the OS to install Repo changes
sudo yum upgrade -y
# Install Jenkins + Java
sudo yum install jenkins java-1.8.0-openjdk-devel -y
# Reload Daemon Service
sudo systemctl daemon-reload
# Start Jenkins Service
sudo systemctl start jenkins
# Check Service Status
sudo systemctl status jenkins