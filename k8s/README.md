# Setup

## General netwokring

The 10.30.0.0/24 subnet is reserved for wireguard hosts
The 10.50.0.0/24 subnet is FIS Proxmox infrastructure
The 10.80.0.0/16 subnet is Homa Prox infrastructure

Hetzner proxy - 10.30.0.1
Homa prox     - 10.30.0.8

## K8s netowrking

Cluster VIP: 10.80.80.1
Cluster LB : 10.80.80.40-10.80.80.90

kcp-0 - 10.80.50.1/16
kcp-1 - 10.80.50.2/16

kwp-0 - 10.80.60.1/16
kwp-1 - 10.80.60.2/16
kwp-2 - 10.80.60.3/16
kwp-3 - 10.80.60.4/16
kwp-4 - 10.80.60.5/16

ksp-0 - 10.80.70.1/16 !reserved for future use
ksp-1 - 10.80.70.2/16 !reserved for future use
