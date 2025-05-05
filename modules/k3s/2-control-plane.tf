resource "proxmox_vm_qemu" "control_plane" {
  for_each        = { for idx, host in var.control_plane : host.hostname => host }
  target_node     = var.target_node
  clone_id        = var.template_id
  full_clone      = false
  name            = each.key
  agent_timeout   = 1
  ci_wait         = 1
  clone_wait      = 1
  additional_wait = 1

  # Enable QEMU Agent
  agent = 1

  # VM Configuration
  cores    = var.control_plane_cpu_cores
  memory   = var.control_plane_memory
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  cpu_type = "host"
  sockets  = 1

  # Serial Console output
  serial {
    id   = 0
    type = "socket"
  }

  # Network configuration
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    id     = 1
    model  = "virtio"
    bridge = var.internal_interface
  }

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = var.vm_disk_storage
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = var.control_plane_disk_size
          storage = var.vm_disk_storage
          backup  = false
        }
      }
    }
  }

  # Cloud-Init configuration
  os_type   = "cloud-init"
  boot      = "order=virtio0"
  ipconfig0 = var.main_network_config
  ipconfig1 = "ip=${each.value.ip_cidr}"
  ciuser    = "root"
  sshkeys   = file("./pub_keys.pub")
}
