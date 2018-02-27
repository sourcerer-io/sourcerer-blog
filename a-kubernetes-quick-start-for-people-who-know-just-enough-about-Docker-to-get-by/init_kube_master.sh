#!/bin/bash

apt-get update
apt-get install -y docker.io
apt-get update
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl
export MASTER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
export INIT_OUTPUT=$(kubeadm init --apiserver-advertise-address $MASTER_IP)
echo $INIT_OUTPUT > $HOME/init-output.txt
grep -o "kubeadm join --token [a-zA-Z0-9\.]* [0-9\.]*:6443 --discovery-token-ca-cert-hash sha256:[a-zA-Z0-9]*" $HOME/init-output.txt > $HOME/worker_join.sh
cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
sysctl net.bridge.bridge-nf-call-iptables=1
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
cat $HOME/worker_join.sh