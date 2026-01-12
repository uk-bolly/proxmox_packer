# Rocky9 family bios vars

iso_type     = "minimal.iso"
iso_checksum = "none"
boot_cmd     = "<tab><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/EL9-ks.cfg<enter><wait>"
boot_type    = "seabios"
cpu_sockets  = "1"
cpu_core     = "2"
cpu_type     = "host"
memory       = "2048"
os_flavour   = "Rocky"
os_major     = "9"
os_minor     = "6"
vm_id        = "8091" # 8 Rocky - 09 OS version - 1 Bios
vm_pool      = "el9_pool"
tags         = "redhat;rocky;rhel9"
