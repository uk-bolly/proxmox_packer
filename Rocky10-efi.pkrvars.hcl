# RHEL10 EFI Packer_vars

iso_type        = "minimal.iso"
iso_checksum    = "none"
boot_cmd        = "e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/EL10-ks.cfg<leftCtrlOn>x<leftCtrlOff>"
boot_type       = "ovmf"
bootloader_type = "EFI"
cpu_sockets     = "1"
cpu_cores       = "2"
memory          = "4096"
os_flavour      = "Rocky"
os_major        = "10"
os_minor        = "1"
vm_id           = "1102" # 9 Alma - 10 OS version - 1 EFI
vm_pool         = "el10_pool"
tags            = "redhat;rocky10"
