# Rocky9 family bios vars

iso_type     = "minimal.iso"
iso_checksum = "none"
boot_cmd     = "<tab><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/8-bios-ks.cfg<enter><wait>"
boot_type    = "seabios"
cpu_sockets  = "1"
cpu_core     = "2"
cpu_type     = "host"
memory       = "2048"
os_flavour   = "AlmaLinux"
os_major     = "8"
os_minor     = "10"
vm_id        = "1081" # 8 Alma - 08 OS version - 1 Bios
vm_pool      = "el8_pool"
tags         = "redhat;alma8"
