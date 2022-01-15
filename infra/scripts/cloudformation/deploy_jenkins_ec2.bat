aws cloudformation  deploy --template-file infra\cloudformation_templates\ssh_ec2_securitygroup.yaml --stack-name SecurityGroups
aws cloudformation deploy --template-file infra\cloudformation_templates\jenkins_ec2.yaml --stack-name JenkinsEC2
aws cloudformation deploy --template-file infra\cloudformation_templates\jenkins_agent_ec2.yaml --stack-name JenkinsEC2Agent