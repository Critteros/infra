#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

: "${NODE_IP:?NODE_IP environment variable must be set}"

k3sup join \
  --ip $NODE_IP \
  --user admin \
  --ssh-key $HOME/.ssh/id_ed25519 \
  --server-ip 10.80.80.1 \
  --k3s-version v1.32.5+k3s1 \
  --k3s-extra-args "--node-ip=$NODE_IP"