include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "secrets" {
  path           = find_in_parent_folders("secrets.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

terraform {
  source = "${get_repo_root()}/modules/k3s"
}

inputs = {
  # Proxmox authentication
  proxmox_host         = include.env.locals.proxmox_host
  proxmox_token_id     = include.env.locals.proxmox_token_id
  proxmox_token_secret = include.secrets.locals.proxmox_token_secret

  # Proxmox host configuration
  template_id        = "9000"
  internal_interface = "internalbr"
  target_node        = "pve"
  vm_disk_storage    = "local-zfs"
  gateway_ip         = "10.80.0.1"
  nameserver         = "1.1.1.1"

  # Control plane configuration
  control_plane = [
    {
      hostname = "kcp-0"
      ip_cidr  = "10.80.50.1/16"
    },
    {
      hostname = "kcp-1"
      ip_cidr  = "10.80.50.2/16"
    },
    {
      hostname = "kcp-2"
      ip_cidr  = "10.80.50.3/16"
    }
  ]
  control_plane_cpu_cores = 2
  control_plane_memory    = 2048
  control_plane_disk_size = "60G"

  # Worker configuration
  workers = [
    {
      hostname = "kwp-0"
      ip_cidr  = "10.80.60.1/16"
    },
    {
      hostname = "kwp-1"
      ip_cidr  = "10.80.60.2/16"
    },
    {
      hostname = "kwp-2"
      ip_cidr  = "10.80.60.3/16"
    },
    {
      hostname = "kwp-3"
      ip_cidr  = "10.80.60.4/16"
    },
    {
      hostname = "kwp-4"
      ip_cidr  = "10.80.60.5/16"
    }
  ]
  worker_cpu_cores = 4
  worker_memory    = 4096
  worker_disk_size = "40G"
}