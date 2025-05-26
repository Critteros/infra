#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

kubectl apply -f https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml

kubectl create configmap -n kube-system kubevip --from-literal range-global=10.80.80.40-10.80.80.90