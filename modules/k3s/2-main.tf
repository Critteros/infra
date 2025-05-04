resource "proxmox_vm_qemu" "test-vm" {
  target_node = "local-pve"
  clone_id    = var.template_id
  full_clone  = false
  vmid        = 1000

  # Enable QEMU Agent
  agent = 1
  # VM Configuration
  cores    = 2
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  cpu_type = "host"
  sockets  = 1

  # Serial Console
  serial {
    id   = 0
    type = "socket"
  }

  # Network Configuration
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
          storage = "local-disks"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "20G"
          storage = "local-disks"
          backup  = false
        }
      }
    }
  }

  # Cloud-Init Configuration
  os_type   = "cloud-init"
  boot      = "order=virtio0"
  ipconfig0 = "ip=192.168.1.26/24,gw=192.168.1.1"
  ipconfig1 = "ip=10.80.0.2/16,gw=10.80.0.1"
  ciuser    = "root"
  sshkeys   = file("./id_ed25519.pub")
}
