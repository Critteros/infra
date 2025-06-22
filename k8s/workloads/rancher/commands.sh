# Rancher repostiry with latest changes
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# Namespace creation
kubectl create namespace cattle-system

# Install cert
kubectl -n cattle-system create secret generic tls-ca  --from-file=cacerts.pem

# Install Rancher
helm install --namespace=cattle-system \
    rancher rancher-stable/rancher -f rancher-values.yaml

helm upgrade --namespace cattle-system \
    rancher rancher-stable/rancher -f rancher-values.yaml