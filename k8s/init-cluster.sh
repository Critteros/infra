#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Args explanation:
# --cluster: Install a new cluster
# --ip: The IP address of the server node
# --tls-san: Additional SANs for the TLS certificate
# --user: The user to use for SSH connections
# --no-extras: Do not install trafeik or servicelb
# --context: The name of the kubeconfig context to create
# --local-path: The path to the kubeconfig file
# --k3s-channel: The channel to use for k3s (latest, stable, etc.)
# --k3s-extra-args: Additional arguments to pass to k3s
# --ssh-key: The path to the SSH private key to use for the connection

k3sup install \
  --cluster \
  --ip 10.80.50.1 \
  --tls-san 10.80.80.1 \
  --tls-san k8s.homa-server.eu \
  --user admin \
  --no-extras \
  --context homa-k8s \
  --local-path $HOME/.kube/config \
  --k3s-channel latest \
  --k3s-extra-args "--node-ip=10.80.50.1" \
  --ssh-key $HOME/.ssh/id_ed25519