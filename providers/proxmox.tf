variable "proxmox_host" {}
variable "terraform_token_id" {
  sensitive = true
}
variable "terraform_token_secret" {
  sensitive = true
}

variable "tls_insecure" {
  default = true
}

provider "proxmox" {
  pm_api_url          = "https://${var.proxmox_host}:8006/api2/json"
  pm_api_token_id     = var.terraform_token_id
  pm_api_token_secret = var.terraform_token_secret
  pm_tls_insecure     = var.tls_insecure
}
