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

# this command will grab the public ip of the master node
export MASTER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# initialise the kubernetes cluster
kubeadm init --apiserver-advertise-address $MASTER_IP
# this will return a command with a token;
# make sure to SAVE THE WHOLE COMMAND so you can use it to join worker nodes to the cluster

# copy the config file so you can access the cluster
cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

# install the pod network; without a network the pods cannot talk to eachother
sysctl net.bridge.bridge-nf-call-iptables=1
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"


######################################################################################

# OR - use init_kube_master.sh as a single command