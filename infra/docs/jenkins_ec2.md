
### DNS Components

![Alt text](../images/dns.png?raw=true "DNS")

### [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/)

#### **Pre-requisutes for EC2 machines**
- Create a EC2 key pair 
- Safely store it with reduced permissions ( chmod 400 )
- Create a Security Group allowing ingress for SSH connection 


All the deployment is done via cloudformation templates.
Below are the relevant links used 

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html#template-anatomy-outline.yaml

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html


### AWS CloudFormation 
- YAML templates are deployed as a stack

### **Commands to install Jenkins**

Update the OS
> sudo yum update –y

Add repo config for Jenkins
> sudo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo

Import Repo Keys
> sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

Install extras 
> sudo amazon-linux-extras install epel -y

Rerun the update
> sudo yum update -y

Upgrade the OS to install Repo changes
> sudo yum upgrade

Install Jenkins + Java
> sudo yum install jenkins java-1.8.0-openjdk-devel

Reload Daemon Service
> sudo systemctl daemon-reload

Start Jenkins Service
>  sudo systemctl start jenkins

Check Service Status
> sudo systemctl status jenkins

Open the URL in browser
> Connect to http://<your_server_public_DNS>:8080 

All above commands can be packaged into a bash script and provided as a user data to ec2 machine.

**Point to remember**
- If you are deleting cloudformation stack using delete-stack command, it is better to run 'wait stack-delete-complete' subsequently to wait for its completion.