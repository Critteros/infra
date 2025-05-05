include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/k3s"
}

inputs = {
  # Proxmox authentication
  proxmox_host     = "homa-prox.critteros.dev"
  proxmox_token_id = "terraform-prov@pve!terraform"

  # Proxmox host configuration
  template_id        = "9000"
  internal_interface = "internalbr"
  target_node        = "pve"
  vm_disk_storage    = "local-zfs"

  # Control plane configuration
  control_plane = [
    {
      hostname = "rcp-0"
      ip_cidr  = "10.80.50.1/16"
    },
    {
      hostname = "rcp-1"
      ip_cidr  = "10.80.50.2/16"
    }
  ]
  control_plane_cpu_cores = 2
  control_plane_memory    = 2048
  control_plane_disk_size = "60G"
}