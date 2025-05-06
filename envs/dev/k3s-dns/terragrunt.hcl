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
  source = "${get_repo_root()}/modules/k3s-dns"
}

dependency "k3s" {
  config_path = "../k3s"
  mock_outputs = {
    control_plane_vm_ips = {
      "kcp-0" = "10.50.0.1",
      "kcp-1" = "10.50.0.2"
    }
    worker_vm_ips = {
      "kwp-0" = "10.60.0.1",
      "kwp-1" = "10.60.0.2"
    }
  }
}

inputs = {
  cloudflare_api_token = include.secrets.locals.cloudflare_api_token
  zone_name            = include.env.locals.cloudflare_zone
  subdomain            = "local"
  hostname_ip_map = merge(
    dependency.k3s.outputs.control_plane_vm_ips,
    dependency.k3s.outputs.worker_vm_ips
  )
}