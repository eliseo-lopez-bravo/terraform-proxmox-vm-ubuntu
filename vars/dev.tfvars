environment = "dev"

proxmox_api_url   = "https://192.168.3.168:8006/api2/json"
proxmox_insecure = true

proxmox_node    = "linux-box"
template_vm_id  = 9000
vm_id           = 101
vm_name         = "CoClaw"

datastore_id    = "local-lvm"
vm_cores        = 2
vm_memory_mb    = 4096
vm_disk_gb      = 60

bridge          = "vmbr0"
ipv4_address    = "192.168.3.175/24"
ipv4_gateway    = "192.168.3.1"

# vm_username     = "ubuntu"
