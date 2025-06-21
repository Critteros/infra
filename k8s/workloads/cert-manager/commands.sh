helm repo add jetstack https://charts.jetstack.io --force-update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.18.0 \
  --set crds.enabled=true

# Create cloudflare secret
kubectl create secret -n cert-manager generic cloudflare-api-token-secret --from-literal=api-token=<REDACTED>