variable "architecture" {}
variable "arch" {
  type = map
}

# Note
# Left is vagrant cloud arch naming - right is DVD arch naming
arch = {
  "x86_64"  = "amd64"
  "aarch64" = "arm64"
}

variable "bootloader" {
  type = map
}
# Note
# Left is variable naming - right is correct value to be passed
bootloader = {
  "bios" = "seabios"
  "efi"  = "ovmf"
}

variable "boot_cmd" {
  type    = string
  default = "<tab><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/9-bios-kickstart.cfg<enter><wait>"
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
  default = "proxmox1"
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "cpu_sockets" {
  type    = integer
  default = "1"
}

variable "cpu_cores" {
  type    = integer
  default = "2"
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "disk_type" {
  type    = string
  default = "virtio"
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
  type    = integer
  default = "2048"
}

variable "local_iso" {
  type    = string
  default = "Virtmachines:iso"
}

variable "iso_url" {
  type = string
  #default = "url to iso location"
}

variable "iso_name" {
  type = string
}

variable "storage_pool" {
  type    = string
  default = "Virtmachines"
}

variable "ssh_user" {
  type    = string
  default = "vagrant"
}

variable "ssh_key_file" {
  type    = string
  default = "~/.ssh/homelab_rsa"
}

variable "template_name" {
  type    = string
  default = "unknown"
}

variable "vga_type" {
  type    = string
  default = "std"
}
