terraform {
  required_version = ">= 1.14.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.99.0"
    }
  }
}

#####################
# Ubuntu 24 VM
#####################

resource "proxmox_virtual_environment_vm" "ubuntu24" {
  name      = var.vm_name
  node_name = var.proxmox_node
  vm_id     = var.vm_id
  tags      = ["ubuntu24", "terraform"]

  # Clone from existing Ubuntu 24.04 cloud-init template
  clone {
    vm_id = var.template_vm_id
    full  = true
  }

  cpu {
    type  = "host"
    cores = var.vm_cores
  }

  memory {
    dedicated = var.vm_memory_mb
  }

  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = var.vm_disk_gb
  }

  network_device {
    bridge = var.bridge
    model  = "virtio"
  }

  agent {
    # enabled = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      username = var.vm_username
      keys     = [var.ssh_public_key]
    }

    # Optional: set hostname
    # dns {
    #   domain  = "local.lan"
    #   servers = ["192.168.1.1"]
    # }
  }

  started = true
}
