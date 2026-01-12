packer {
  required_plugins {
    proxmox = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "proxmox01"
}

variable "storage_pool" {
  type    = string
  default = "local"
}

variable "os_arch" {
  type    = string
  default = "x86_64"
}

variable "bootloader_type" {
  type    = string
  default = "BIOS"
}

variable "boot_type" {
  type    = string
  default = ""
}

variable "boot_cmd" {
  type    = string
  default = ""
}

variable "boot_disk_size" {
  type    = string
  default = "25G"
}

variable "cpu_sockets" {
  type    = number
  default = "1"
}

variable "cpu_cores" {
  type    = number
  default = "2"
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "disk_type" {
  type    = string
  default = "scsi"
}

variable "nic_type" {
  type    = string
  default = "vmxnet3"
}

variable "vm_pool" {
  type    = string
  default = "Unassigned"
}

variable "memory" {
  type    = number
  default = "2048"
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "iso_name" {
  type    = string
  default = ""
}

variable "iso_type" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = "none"
}

variable "os_flavour" {
  type    = string
  default = ""
}

variable "os_major" {
  type    = string
  default = ""
}

variable "os_minor" {
  type    = string
  default = ""
}

variable "os_type" {
  type    = string
  default = "l26"
}

variable "ssh_user" {
  type    = string
  default = "vagrant"
}

variable "ssh_pass" {
  type    = string
  default = "vagrant"
}

variable "tags" {
  type    = string
  default = ""
}

variable "use_cloud_init" {
  type        = bool
  description = "Whether to use cloud int for ubuntu and to run could init or not"
  default     = false
}

variable "cloud_init_storage_pool" {
  type        = string
  description = "Location of the storage for cloud init files"
  default     = ""
}

variable "vga_type" {
  type    = string
  default = ""
}

variable "vm_id" {
  type        = string
  description = "The ID that the host will be be given on proxmox"
}

locals {
  # Build up ISO name
  # If the variable iso_name is not empty use it else build the name
  iso_name = var.iso_name != "" ? var.iso_name : join("-", [
    "${var.os_flavour}",
    "${var.os_major}.${var.os_minor}",
    "${var.os_arch}",
    "${var.iso_type}"
  ])
}

locals {
  # Build up template name
  template_name = join("-", [
    "${var.os_flavour}",
    "${var.os_major}.${var.os_minor}",
    "${var.bootloader_type}",
    "TEMPLATE",
  ])
}

source "proxmox-iso" "proxmox_tmpl" {
  proxmox_url              = "https://${var.proxmox_api_url}/api2/json"
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true
  node                     = var.proxmox_node
  bios                     = var.boot_type
  scsi_controller          = "virtio-scsi-single"
  os                       = var.os_type
  boot_iso {
    type             = "ide"
    iso_file         = "${var.storage_pool}:iso/${local.iso_name}"
    unmount          = true
    iso_checksum     = var.iso_checksum
    iso_storage_pool = var.storage_pool
  }
  disks {
    disk_size    = var.boot_disk_size
    storage_pool = var.storage_pool
    type         = var.disk_type
    format       = "qcow2"
  }
  efi_config {
    efi_storage_pool  = var.storage_pool
    pre_enrolled_keys = true
    efi_format        = "raw"
    efi_type          = "4m"
  }
  cpu_type   = var.cpu_type
  cores      = var.cpu_cores
  sockets    = var.cpu_sockets
  memory     = var.memory
  qemu_agent = true
  network_adapters {
    bridge   = "vmbr0"
    model    = var.nic_type
    firewall = true
  }
  vga {
    type = var.vga_type
  }
  boot_command = ["${var.boot_cmd}"]
  # VM Cloud-Init Settings
  cloud_init              = var.use_cloud_init ? var.use_cloud_init : null
  cloud_init_storage_pool = var.use_cloud_init ? var.cloud_init_storage_pool : null
  pool                    = var.vm_pool
  http_directory          = "http"
  ssh_username            = var.ssh_user
  ssh_password            = var.ssh_pass
  ssh_timeout             = "30m"
  ssh_handshake_attempts  = "100"
  tags                    = var.tags
  template_name           = "${local.template_name}"
  template_description    = "${var.os_flavour}${var.os_major}.${var.os_minor}, generated on ${timestamp()}"
  vm_id                   = var.vm_id
}

build {
  sources = ["source.proxmox-iso.proxmox_tmpl"]
}
