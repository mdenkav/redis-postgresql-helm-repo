#!/bin/bash

cd /home/ec2-user/

apt update -y & apt upgrade -y

apt install git-all -y

git --version

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
systemctl start docker & systemctl enable docker
docker ps

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --force

kubectl get nodes

helm ls

git init deniztest.git

cd /home/ec2-user/deniztest.git

helm create redis
helm create postgresql
touch README.md
touch all_infra_installation.sh

git add .
git config --global user.email "mdenizkavruk@gmail.com"
git config --global user.name "Deniz"
git commit -m "firstcommit"
git status

#Bu aşamada repodan helm deploy yapılabilir.Bu test çalışmasında bitnami hazır helm reposundan imaj çekilerek doğrudan kurulum yapılmıştır.
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo ls
helm install my-redis bitnami/redis
helm install my-redis bitnami/postgresql
helm ls

#Eğer git reposundaki helm chartlar tam düzenlenmiş olsaydı aşağıdaki gibi kurulum yapılabilecektir.
#helm install deniz-postgresql postgresql
#helm install deniz-redis redis

#veya helm reposu sadece helm chartlardan oluşuyorsa tek adımda kurulum yapılabilir.
#helm install deniz-deployment deniztest
