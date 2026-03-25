#####################
# Core / Provider
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

variable "proxmox_insecure" {
  type        = bool
  default     = false
  description = "Allow insecure TLS"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod)"
}

#####################
# VM Config
#####################

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
