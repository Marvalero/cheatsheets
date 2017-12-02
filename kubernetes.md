# Kubernetes
## kubectl
```bash
# Clean resources
SERVICE=$2
kubectl get deployments | grep $SERVICE | awk '{ print $1 }' | xargs kubectl  delete deployments
kubectl get services | grep $ERVICE | awk '{ print $1 }' | xargs kubectl delete services
kubectl get pods | grep $SERVICE | awk '{ print $1 }' | xargs kubectl delete pods
kubectl get secrets | grep $1 | awk '{ print $1 }' | xargs kubectl delete secrets
kubectl get configmap | grep $1 | awk '{ print $1 }' | xargs kubectl configmap secrets

# Forward port
POD_NAME=$2
PORT=$3
`kubectl port-forward $POD_NAME $PORT:$PORT`
```
