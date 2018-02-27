apt-get update
apt-get install -y docker.io
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl
export WORKER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# replace with output from init_kube_master.sh
kubeadm join --token <token> <master_ip>:6443 --discovery-token-ca-cert-hash sha256:<token_hash>