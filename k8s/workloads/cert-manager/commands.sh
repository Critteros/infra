helm repo add jetstack https://charts.jetstack.io --force-update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.18.0 \
  --set crds.enabled=true

# Create cloudflare secret
kubectl create secret -n cert-manager generic cloudflare-api-token-secret --from-literal=api-token=<REDACTED>


helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm upgrade --install \
  external-dns \
  external-dns/external-dns \
  --values external-dns-values.yaml \
  --namespace cert-manager