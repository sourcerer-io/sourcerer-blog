# install docker
apt-get update
apt-get install -y docker.io

# install kubernetes
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl

# this command will grab the public ip of the worker node
export WORKER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# run the join command returned from the init command you ran on the master node
kubeadm join --token <token> <master_ip>:6443 --discovery-token-ca-cert-hash sha256:<token_hash>

################################################################################################

# OR - use init_kube_worker.sh as a single command