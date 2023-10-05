#!/bin/bash

#/home/ec2-user/ dizin değişikliği benim test ortamı özelindedir.
cd /home/ec2-user/

echo "Sunucu Update Başlıyor..."  
apt update -y & apt upgrade -y
echo "Sunucu Update Tamamlandı."

echo "Gerekli paket kurulumları ve GIT kurulumu başlıyor..."
apt install git-all curl wget htop -y
git --version
echo "Gerekli paket kurulumları ve GIT kurulumu tamamlandı."

echo "Helm paket kurulumu başlıyor..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
echo "Helm paket kurulumu tamamlandı."

sleep 2
echo "Docker Servis kurulumu başlıyor..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
systemctl start docker & systemctl enable docker
echo "Docker Servis kurulumu tamamlandı."
docker ps

sleep 2
echo "Minikube ve kubectl kurulumu başlıyor..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --force
echo "Minikube ve kubectl kurulumu tamamlandı."

kubectl get nodes
sleep 2
helm ls

echo "GIT ve HELM redis ve postgresql deployları başlıyor..." 
git init deniztest

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
helm install my-postgresql bitnami/postgresql
echo "GIT ve HELM redis ve postgresql deployları tamamlandı."
sleep 2
helm ls
kubectl get pods

#Eğer git reposundaki helm chartlar tam düzenlenmiş olsaydı aşağıdaki gibi kurulum yapılabilecektir.
#helm install deniz-postgresql postgresql
#helm install deniz-redis redis

#veya helm reposu sadece helm chartlardan oluşuyorsa tek adımda kurulum yapılabilir.
#helm install deniz-deployment deniztest
