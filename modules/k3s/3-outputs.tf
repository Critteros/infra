output "control_plane_vm_ids" {
  description = "VM IDs of control plane instances"
  value = {
    for idx, vm in proxmox_vm_qemu.control_plane :
    "rcp-${idx}" => vm.vmid
  }
}
