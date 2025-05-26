
# Add helm chart
helm repo add traefik https://traefik.github.io/charts

# Update repo
helm repo update

# Create namespace for trafeik
kubectl create namespace trafeik-private

# Installation, to change replace install with upgrade
helm install --namespace=trafeik-private \
    traefik-private traefik/traefik

helm upgrade --namespace=trafeik-private \
    traefik-private traefik/traefik -f trafeik-values.yaml