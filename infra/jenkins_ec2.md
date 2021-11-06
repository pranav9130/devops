
### DNS Components

![Alt text](images/dns.png?raw=true "DNS")

### [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/)

#### **Pre-requisutes for EC2 machines**
- Create a EC2 key pair 
- Safely store it with reduced permissions ( chmod 400 )
- Create a Security Group allowing ingress for SSH connection 


All the deployment is done via cloudformation templates.
Below are the relevant links used 

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html#template-anatomy-outline.yaml

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html
