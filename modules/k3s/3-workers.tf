resource "proxmox_vm_qemu" "workers" {
  for_each      = { for idx, host in var.workers : host.hostname => host }
  target_node   = var.target_node
  clone_id      = var.template_id
  full_clone    = false
  name          = each.key
  agent_timeout = 1

  # Enable QEMU Agent
  agent = 1

  # VM Configuration
  cores    = var.worker_cpu_cores
  memory   = var.worker_memory
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
          size    = var.worker_disk_size
          storage = var.vm_disk_storage
          backup  = false
        }
      }
    }
  }

  # Cloud-Init configuration
  os_type    = "cloud-init"
  boot       = "order=virtio0"
  ipconfig0  = "ip=${each.value.ip_cidr},gw=${var.gateway_ip}"
  nameserver = var.nameserver
  ciuser     = "root"
  sshkeys    = file("./pub_keys.pub")
}
