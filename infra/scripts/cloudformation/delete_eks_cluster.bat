eksctl delete cluster --name test-eks-cluster
aws cloudformation  wait stack-delete-complete --stack-name  eksctl-test-eks-cluster-cluster
aws cloudformation  wait stack-delete-complete --stack-name  eksctl-test-eks-cluster-addon-iamserviceaccount-kube-system-aws-node
aws cloudformation  wait stack-delete-complete --stack-name  eksctl-test-eks-cluster-nodegroup-ng-cb8417b3