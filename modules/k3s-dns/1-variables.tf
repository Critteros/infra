variable "zone_name" {
  description = "Zone name"
  type        = string
}

variable "hostname_ip_map" {
  description = "Map of hostnames to ip adresses"
  type        = map(string)
}

variable "subdomain" {
  description = "Subdomain for added DNS records"
  type        = string
  default     = ""
}
