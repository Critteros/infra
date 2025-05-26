#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

: "${NODE_IP:?NODE_IP environment variable must be set}"

k3sup join \
  --ip $NODE_IP \
  --user admin \
  --ssh-key $HOME/.ssh/id_ed25519 \
  --server \
  --server-ip 10.80.80.1 \
  --k3s-channel latest \
  --k3s-extra-args "--node-ip=$NODE_IP --tls-san 10.80.80.1 --tls-san k8s.homa-server.eu" \
  --no-extras