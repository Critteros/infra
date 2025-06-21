#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Get latest image
ctr image pull docker.io/plndr/kube-vip:latest

alias kube-vip="ctr image pull ghcr.io/kube-vip/kube-vip:latest; ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:latest vip /kube-vip"

mkdir -p /var/lib/rancher/k3s/server/manifests/

kube-vip manifest daemonset \
--arp \
--interface eth0 \
--address 10.80.80.1 \
--controlplane \
--leaderElection \
--taint \
--services \
--inCluster | tee /var/lib/rancher/k3s/server/manifests/kube-vip.yaml