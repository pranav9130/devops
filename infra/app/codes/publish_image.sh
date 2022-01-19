sudo amazon-linux-extras install docker
sudo service docker start
sudo systemctl enable docker
docker build -t hello-world .
aws ecr create-repository --repository-name hello-repository --region us-east-2
docker tag hello-world 775782155147.dkr.ecr.us-east-2.amazonaws.com/hello-repository
aws ecr --region us-east-2 get-login-password | docker login --username AWS --password-stdin 775782155147.dkr.ecr.us-east-2.amazonaws.com
docker push 775782155147.dkr.ecr.us-east-2.amazonaws.com/hello-repository
