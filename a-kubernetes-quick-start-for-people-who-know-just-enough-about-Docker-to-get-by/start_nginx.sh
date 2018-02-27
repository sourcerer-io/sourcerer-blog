kubectl run nginx --image=nginx --replicas=1
kubectl expose deployment nginx --external-ip=$MASTER_IP --port=80 --target-port=80
kubectl scale --replicas=3 deployment nginx