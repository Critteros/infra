output "control_plane_vm_ids" {
  description = "VM IDs of control plane instances"
  value = {
    for idx, vm in proxmox_vm_qemu.control_plane :
    vm.name => vm.vmid
  }
}

output "worker_vm_ids" {
  description = "VM IDs of worker instances"
  value = {
    for idx, vm in proxmox_vm_qemu.workers :
    vm.name => vm.vmid
  }
}

output "control_plane_vm_ips" {
  description = "Mapping of control plane instance names to their IPs without CIDR suffix"
  value = {
    for idx, vm in var.control_plane :
    vm.hostname => split("/", vm.ip_cidr)[0]
  }
}

output "worker_vm_ips" {
  description = "Mapping of worker instance names to their IPs without CIDR suffix"
  value = {
    for idx, vm in var.workers :
    vm.hostname => split("/", vm.ip_cidr)[0]
  }
}
