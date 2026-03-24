terraform {
  required_version = ">= 1.14.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.99.0"
    }
  }
}

provider "proxmox" {
  endpoint   = var.proxmox_api_url
  api_token  = var.proxmox_api_token
  insecure   = true
  ssh {
    agent    = false
  }
}

#####################
# Variables
#####################

variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL"
}

variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token"
  sensitive   = true
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name that holds the template and will run the VM"
}

variable "template_vm_id" {
  type        = number
  description = "VM ID of the Ubuntu 24.04 cloud-init template (9000)"
}

variable "vm_id" {
  type        = number
  description = "VM ID for the new VM (101)"
}

variable "vm_name" {
  type        = string
  description = "Name of the new VM"
}

variable "datastore_id" {
  type        = string
  description = "Target storage ID (local-lvm)"
}

variable "vm_cores" {
  type        = number
  default     = 2
}

variable "vm_memory_mb" {
  type        = number
  default     = 2048
}

variable "vm_disk_gb" {
  type        = number
  default     = 10
}

variable "bridge" {
  type        = string
  default     = "vmbr0"
}

variable "ipv4_address" {
  type        = string
  description = "IPv4 address with prefix (192.168.1.50/24)"
}

variable "ipv4_gateway" {
  type        = string
  description = "IPv4 default gateway"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to inject into the VM"
  sensitive   = true
}

variable "vm_username" {
  type        = string
  default     = "ubuntu"
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
