# General configuration for VMs
variable "internal_interface" {
  description = "Internal interface used for communication within the cluster"
  type        = string
}

variable "main_interface" {
  description = "Main network interface for egress"
  type        = string
  default     = "vmbr0"
}

variable "template_id" {
  description = "Id of template to create VM clones of"
  type        = number
}

variable "target_node" {
  description = "Proxmox mode where to create VMs"
  type        = string
}

variable "main_network_config" {
  description = "Main network configuration in proxmox cloudinit format"
  type        = string
  default     = "ip=dhcp"
}

variable "vm_disk_storage" {
  description = "Storage used for VM disks"
  type        = string
}


# Control plane configuration
variable "control_plane" {
  description = "Control plane hosts configuration"
  type = list(object({
    hostname = string
    ip_cidr  = string
  }))
}


variable "control_plane_cpu_cores" {
  description = "Number of CPU cores for control plane instances"
  type        = number
  default     = 2
}

variable "control_plane_memory" {
  description = "Amount of memory for control plane instances"
  type        = number
  default     = 2048
}

variable "control_plane_disk_size" {
  description = "Disk size for control plane instances"
  type        = string
  default     = "60G"
}
