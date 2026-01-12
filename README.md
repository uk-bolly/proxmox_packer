# Proxmox Packer Templates

This repository contains HashiCorp Packer configurations for building VM templates on Proxmox VE. It supports multiple Linux distributions with both BIOS and EFI boot configurations.

## Overview

This Packer setup automates the creation of VM templates in Proxmox for various Linux distributions including:
- AlmaLinux (8, 9, 10)
- Rocky Linux (8, 9, 10)
- Red Hat Enterprise Linux (RHEL) (9, 10)
- Ubuntu (24.04)
- Debian (11, 12, 13)

Each distribution can be built with either BIOS or EFI boot configurations.

## Prerequisites

- HashiCorp Packer installed (version 1.7.0 or later)
- Proxmox VE cluster or single node
- Proxmox API token with appropriate permissions
- ISO files uploaded to Proxmox storage pool
- Network access to Proxmox API endpoint

## Required Packer Plugin

The Proxmox plugin for Packer is required. It will be automatically installed when you run Packer for the first time:

```hcl
proxmox = {
  version = ">= 1.2.1"
  source  = "github.com/hashicorp/proxmox"
}
```

## Configuration

### Proxmox API Credentials

Create a `proxmox.pkrvars.hcl` file (or copy from the example) with your Proxmox API credentials:

```hcl
proxmox_api_url = "your-proxmox-host:8006"
proxmox_api_token_id = "user@pam!token_name"
proxmox_api_token_secret = "your-token-secret"
proxmox_node = "proxmox01"
storage_pool = "your-storage-pool"
```

**Important:** Do not commit `proxmox.pkrvars.hcl` to version control as it contains sensitive credentials. Add it to `.gitignore`.

### ISO Files

ISO files must be uploaded to your Proxmox storage pool in the `iso` directory. The ISO naming convention follows:

```
{os_flavour}-{os_major}.{os_minor}-{os_arch}-{iso_type}
```

For example: `AlmaLinux-10.1-x86_64-minimal.iso`

Alternatively, you can specify a custom ISO name using the `iso_name` variable in the distribution-specific variable files.

## Usage

### Building a Template

To build a template, use Packer with the main configuration file and a distribution-specific variable file:

```bash
packer build -var-file=proxmox.pkrvars.hcl -var-file=Alma10-bios.pkrvars.hcl proxmox.pkr.hcl
```

### Example Build Commands

**AlmaLinux 10 BIOS:**
```bash
packer build -var-file=proxmox.pkrvars.hcl -var-file=Alma10-bios.pkrvars.hcl proxmox.pkr.hcl
```

**AlmaLinux 10 EFI:**
```bash
packer build -var-file=proxmox.pkrvars.hcl -var-file=Alma10-efi.pkrvars.hcl proxmox.pkr.hcl
```

**Ubuntu 24.04 BIOS:**
```bash
packer build -var-file=proxmox.pkrvars.hcl -var-file=ubuntu24-bios.pkrvars.hcl proxmox.pkr.hcl
```

**RHEL 10 BIOS:**
```bash
packer build -var-file=proxmox.pkrvars.hcl -var-file=rhel10-bios.pkrvars.hcl proxmox.pkr.hcl
```

## Supported Distributions

### AlmaLinux
- AlmaLinux 8.10 (BIOS/EFI)
- AlmaLinux 9.6 (BIOS/EFI)
- AlmaLinux 9.7 (BIOS/EFI)
- AlmaLinux 10 (BIOS/EFI)

### Rocky Linux
- Rocky Linux 8.10 (BIOS/EFI)
- Rocky Linux 9.6 (BIOS/EFI)
- Rocky Linux 9.7 (BIOS/EFI)
- Rocky Linux 10 (BIOS/EFI)

### Red Hat Enterprise Linux
- RHEL 10 (BIOS/EFI)

### Ubuntu
- Ubuntu 24.04 (BIOS/EFI)

### Debian
- Debian 11 (BIOS)
- Debian 12 (BIOS)
- Debian 13 (BIOS)

## File Structure

```
proxmox_packer/
├── proxmox.pkr.hcl              # Main Packer configuration
├── proxmox.pkrvars.hcl          # Proxmox API credentials (not in git)
├── variables.pkrvars.hcl        # Common variable definitions
├── {Distribution}-{BootType}.pkrvars.hcl  # Distribution-specific variables
└── http/                        # Kickstart and preseed files
    ├── EL9-ks.cfg               # RHEL 9 family kickstart (AlmaLinux 9, Rocky 9)
    ├── EL10-ks.cfg              # RHEL 10 family kickstart (AlmaLinux 10, Rocky 10, RHEL 10)
    ├── 8-bios-ks.cfg            # RHEL 8 BIOS kickstart
    ├── 8-efi-ks.cfg             # RHEL 8 EFI kickstart
    ├── 9-bios-ks.cfg            # RHEL 9 BIOS kickstart
    ├── 9-efi-ks.cfg             # RHEL 9 EFI kickstart
    ├── RHEL10-bios-ks.cfg       # RHEL 10 BIOS kickstart
    ├── RHEL10-efi-ks.cfg        # RHEL 10 EFI kickstart
    ├── alma10-bios-ks.cfg       # AlmaLinux 10 BIOS kickstart
    ├── alma10-efi-ks.cfg        # AlmaLinux 10 EFI kickstart
    ├── debian-preseed.cfg       # Debian preseed configuration
    ├── debian13-preseed.cfg     # Debian 13 preseed configuration
    ├── ubuntu24-preseed.cfg     # Ubuntu 24.04 preseed configuration
    ├── ubuntu_bios/             # Ubuntu BIOS cloud-init files
    │   ├── meta-data
    │   └── user-data
    ├── ubuntu_efi/              # Ubuntu EFI cloud-init files
    │   ├── meta-data
    │   └── user-data
    └── user-data                # Cloud-init user data
```

## Key Variables

### Required Variables
- `proxmox_api_url`: Proxmox API endpoint (host:port)
- `proxmox_api_token_id`: API token ID
- `proxmox_api_token_secret`: API token secret
- `vm_id`: Unique VM ID for the template

### Common Variables
- `os_flavour`: Operating system name (e.g., "AlmaLinux", "Ubuntu")
- `os_major`: Major version number
- `os_minor`: Minor version number
- `boot_type`: Boot loader type ("seabios" for BIOS, "ovmf" for EFI)
- `iso_type`: ISO type (e.g., "minimal.iso", "dvd.iso")
- `storage_pool`: Proxmox storage pool name
- `vm_pool`: Resource pool for the VM
- `memory`: VM memory in MB
- `cpu_sockets`: Number of CPU sockets
- `cpu_cores`: Number of CPU cores per socket
- `boot_disk_size`: Boot disk size (e.g., "25G")

### Ubuntu/Debian Specific
- `use_cloud_init`: Enable cloud-init support (boolean)
- `cloud_init_storage_pool`: Storage pool for cloud-init files

## Kickstart and Preseed Files

The `http/` directory contains automated installation configuration files:
- **Kickstart files** (`.cfg`): For Red Hat-based distributions (AlmaLinux, Rocky, RHEL)
  - `EL9-ks.cfg`: Used for RHEL 9 family distributions (AlmaLinux 9, Rocky 9)
  - `EL10-ks.cfg`: Used for RHEL 10 family distributions (AlmaLinux 10, Rocky 10, RHEL 10)
  - Distribution-specific kickstart files are also available
- **Preseed files** (`.cfg`): For Debian-based distributions (Debian, Ubuntu)
  - `debian-preseed.cfg`: General Debian preseed configuration
  - `debian13-preseed.cfg`: Debian 13 specific preseed
  - `ubuntu24-preseed.cfg`: Ubuntu 24.04 preseed configuration
- **Cloud-init files**: For Ubuntu automated installation
  - `ubuntu_bios/` and `ubuntu_efi/` directories contain `meta-data` and `user-data` files

These files are served via HTTP during the build process to automate the OS installation.

## Template Naming Convention

Templates are automatically named using the pattern:
```
{os_flavour}-{os_major}.{os_minor}-{bootloader_type}-TEMPLATE
```

Example: `AlmaLinux-10.1-BIOS-TEMPLATE`

## VM Configuration Defaults

- **CPU Type**: host
- **Disk Format**: qcow2
- **Disk Type**: scsi (configurable)
- **Network**: vmbr0 bridge with firewall enabled
- **QEMU Agent**: Enabled
- **SSH User**: vagrant (default)
- **SSH Password**: vagrant (default)

## Customization

### Modifying VM Resources

Edit the distribution-specific `.pkrvars.hcl` file to adjust:
- Memory allocation
- CPU cores and sockets
- Disk size
- Network configuration

### Custom Boot Commands

Modify the `boot_cmd` variable in the distribution variable file to customize the boot process. The boot command uses Packer template variables:
- `{{ .HTTPIP }}`: IP address of the HTTP server
- `{{ .HTTPPort }}`: Port of the HTTP server

### Custom Kickstart/Preseed Files

Modify the files in the `http/` directory to customize the automated installation process. Update the `boot_cmd` variable to reference your custom file.

## Troubleshooting

### Build Failures

1. **ISO not found**: Verify the ISO file exists in the storage pool's `iso` directory with the correct naming convention
2. **API authentication errors**: Verify your API token has sufficient permissions
3. **SSH connection timeout**: Increase `ssh_timeout` in `proxmox.pkr.hcl` or check network connectivity
4. **Boot command issues**: Verify the boot command matches your ISO's boot menu structure

### Common Issues

- **VM ID conflicts**: Ensure `vm_id` is unique for each template
- **Storage pool errors**: Verify the storage pool name and available space
- **Network issues**: Ensure the Proxmox node can reach the HTTP server during build

## Security Notes

- Never commit `proxmox.pkrvars.hcl` containing API credentials
- Use environment variables or a secrets management system for production
- Regularly rotate API tokens
- Review and customize kickstart/preseed files for your security requirements

## License

MIT License

This project is provided as-is for building Proxmox VM templates.
