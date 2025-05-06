variable "proxmox_host" {
  description = "Proxmox host address DNS name or ip"
  type        = string
}

variable "proxmox_token_id" {
  description = "Proxmox PVE token id for authentication"
  sensitive   = true
  type        = string
}
variable "proxmox_token_secret" {
  description = "Proxmox PVE token UUID for authentication"
  sensitive   = true
  type        = string
}

variable "proxmox_tls_insecure" {
  description = "Allow connecting using self signed certificate"
  default     = true
  type        = bool
}

provider "proxmox" {
  pm_api_url          = "https://${var.proxmox_host}:8006/api2/json"
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure     = true
}
