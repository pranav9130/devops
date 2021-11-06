aws cloudformation  delete-stack --stack-name JenkinsEC2
aws cloudformation  wait stack-delete-complete --stack-name JenkinsEC2
aws cloudformation  delete-stack --stack-name SecurityGroups
aws cloudformation  wait stack-delete-complete --stack-name SecurityGroups