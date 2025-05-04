include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/k3s"
}

inputs = {
  proxmox_host           = "pve.local.critteros.dev"
  template_id            = "9000"
  internal_interface     = "internalbr"
  terraform_token_id     = "terraform-prov@pve!terraform"
}