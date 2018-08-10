# Kubernetes
## Container Runtime Interface (CRI)
It is the piece of Kubernetes that starts and stops containers. The default is Docker (it may be replaced by containerd).

## kubectl
```bash
# Forward port
kubectl port-forward $POD_NAME $PORT:$PORT

# Volume Claim
kubectl get pvc

# Get HorizontalPodAutoscaler
kubectl get hpa

# Most used pods
kubectl top pods -n sock-shop

# increase pod cpu
kubectl exec -itn sock-shop <front-end-pod-name> -- sh -c 'yes > /dev/null'

# Do raw request to api
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes" | jq

# Evict pods on a node
kubectl drain no-name

# Scale pods
kubectl scale deployment/carts --replicas=3 -n=sock-shop

# Taint node
kubectl taint nodes node1 node2 key=value


# setting cluster admin role for a service account
kubectl create clusterrolebinding cluster-role-resource-name --clusterrole=cluster-admin --serviceaccount=nginx-ingress:default
```

## Resources

### Config

A configuration file describes clusters, users, and contexts.
 - Context: relates user and cluster
 - Cluster: defines Kubernetes clusters
 - Users: credentials to access to a kubernetes cluster
