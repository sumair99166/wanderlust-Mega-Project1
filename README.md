⚙️ Commands Used (With Purpose)

🐳 Docker (Before building & pushing application images)
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu && newgrp docker

docker build -t <image-name> .
docker tag <image-name> <dockerhub-username>/<image-name>
docker push <dockerhub-username>/<image-name>


⚙️ Jenkins Setup (Before creating CI/CD pipelines)
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install jenkins -y


☁️ AWS CLI (Before interacting with AWS services)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

aws configure


☸️ kubectl (Before managing Kubernetes cluster)
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin

kubectl version --short --client


🚀 eksctl (Before creating EKS cluster)
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

eksctl version

eksctl create cluster --name=wanderlust \
--region=ap-south-1 \
--version=1.30 \
--without-nodegroup

eksctl utils associate-iam-oidc-provider \
--region ap-south-1 \
--cluster wanderlust \
--approve

eksctl create nodegroup --cluster=wanderlust \
--region=ap-south-1 \
--name=wanderlust \
--node-type=t2.large \
--nodes=2 \
--nodes-min=2 \
--nodes-max=2 \
--node-volume-size=29 \
--ssh-access \
--ssh-public-key=eks-nodegroup-key


🔐 SSH Setup (Before connecting Jenkins master to worker)
ssh-keygen


🔍 SonarQube (Before code quality analysis in pipeline)
docker run -itd --name SonarQube-Server -p 9000:9000 sonarqube:lts-community


🛡️ Trivy (Before security scanning of images/filesystem)
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y
sudo apt-get install trivy -y



🔄 ArgoCD (Before deploying application on Kubernetes)
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pods -n argocd

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

kubectl get svc -n argocd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo


🔗 ArgoCD CLI (Before connecting EKS cluster to ArgoCD)
argocd login <ARGOCD_SERVER_IP>:<PORT> --username admin

argocd cluster list

kubectl config get-contexts

argocd cluster add <EKS_CONTEXT_NAME> --name wanderlust-eks-cluster


📊 Helm + Monitoring (After deployment for monitoring setup)
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create namespace prometheus

helm install stable prometheus-community/kube-prometheus-stack -n prometheus

kubectl get pods -n prometheus
kubectl get svc -n prometheus

kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus
kubectl edit svc stable-grafana -n prometheus

kubectl get secret --namespace prometheus stable-grafana \
-o jsonpath="{.data.admin-password}" | base64 --decode ; echo


🧹 Cleanup (After project completion to avoid AWS cost)
eksctl delete cluster --name=wanderlust --region=ap-south-1
