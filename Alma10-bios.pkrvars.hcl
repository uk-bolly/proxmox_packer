# RHEL10 family bios vars

iso_type     = "minimal.iso"
iso_checksum = "none"
boot_cmd     = "<up>e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/EL10-ks.cfg<leftCtrlOn>x<leftCtrlOff>"
boot_type    = "seabios"
cpu_sockets  = "1"
cpu_cores    = "2"
cpu_type     = "host"
memory       = "4096"
os_flavour   = "AlmaLinux"
os_major     = "10"
os_minor     = "1"
vm_id        = "1101" # 1 Alma - 10 OS version - 1 Bios
vm_pool      = "el10_pool"
tags         = "redhat;alma10"
