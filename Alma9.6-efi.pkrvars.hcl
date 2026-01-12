# RHEL9 family efi vars

iso_type        = "minimal.iso"
iso_checksum    = "none"
boot_cmd        = "e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.nompath inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/EL9-ks.cfg<leftCtrlOn>x<leftCtrlOff>"
boot_type       = "ovmf"
bootloader_type = "EFI"
cpu_sockets     = "1"
cpu_core        = "2"
cpu_type        = "host"
memory          = "2048"
os_flavour      = "AlmaLinux"
os_major        = "9"
os_minor        = "6"
vm_id           = "1092" # 9 Alma - 09 OS version - 2 EFI
vm_pool         = "el9_pool"
tags            = "redhat;alma9"
