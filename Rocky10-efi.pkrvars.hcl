# RHEL10 EFI Packer_vars

iso_type     = "minimal.iso"
iso_checksum = "none"
boot_cmd     = "<down>e<down><down><end> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/EL10-ks.cfg fips=1<leftCtrlOn>x<leftCtrlOff>"
boot_type    = "ovmf"
cpu_sockets  = "1"
cpu_cores    = "2"
memory       = "4096"
os_flavour   = "Rocky"
os_major     = "10"
os_minor     = "1"
vm_id        = "8102" # 8 Rocky - 10 OS version - 2 EFI
vm_pool      = "el10_pool"
tags         = "redhat;rocky10"
