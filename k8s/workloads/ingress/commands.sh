# Add helm chart
helm repo add traefik https://traefik.github.io/charts

# Update repo
helm repo update

# Create namespace for ingress workloads
kubectl create namespace ingress

# Install private ingress controller
helm install --namespace=ingress \
    traefik-private traefik/traefik -f traefik-private-values.yaml
# Upgrade private ingress controller
helm upgrade --namespace=ingress \
    traefik-private traefik/traefik -f traefik-private-values.yaml

# Install public ingress controller
helm install --namespace=ingress \
    traefik-public traefik/traefik -f traefik-public-values.yaml
helm upgrade --namespace=ingress \
    traefik-public traefik/traefik -f traefik-public-values.yaml