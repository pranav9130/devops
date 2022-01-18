
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


## Jenkins Agent Setup 
_[Reference](https://www.jenkins.io/doc/book/using/using-agents/)_ 
- Launch Ec2 machine with Java installation 
- This new EC2 machine will be the external build agent that can be used by Jenkins controller to deploy the build work.
- Create SSH key pairs on the build agent using following command 
    > ssh-keygen -f ~/.ssh/jenkins_agent_key
- Append the public key part to authorized_keys 
    > cat ~/.ssh/jenkins_agent_key.pub >> ~/.ssh/authorized_keys 
- Configure the Private SSH Key on Jenkins Controller 
    - Manage Jenkins > Manage Creds > Add Creds ( Global ) 
    - Select Kind "SSH Username with private key"
    - Put the Username to connect 
    - Put the private key and passphrase
- Confgure the Build Node 
    - Manage Jenkins > Manage Nodes > New Node 
    - Select Permanent Agent 
    - Set the root directory for the build agent ( This is where Jenkins writes up the intermediate data into build agent )
    - Select launch method as "Launch agents via SSH"
    - Put the host IP
    - Select the SSH creds set in the eariler setp from the dropdown 
    - Select host key verififcation strat "Known hosts file verification strat"
- Check if the agent is up and running 
- Configure kubectl connection 
    > aws eks update-kubeconfig --region us-east-2 --name test-eks-cluster