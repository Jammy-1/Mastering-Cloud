# Resource Groups
location          = "uksouth"

rg_core_name     = "rg-core-uks"
rg_network_name  = "rg-network-uks"
rg_compute_name  = "rg-compute-uks"
rg_storage_name  = "rg-storage-uks"
rg_security_name = "rg-security-uks"

# Global Tags
global_tags = {
  environment   = "production"
  owner         = "infrastructure"
  project       = "azure-secure-storage-ingestion"
  cost_center   = "IT-Secure-001"
  managed_by    = "Dev"
  business_unit = "IT-Operations"
}

# Resource Group Tags
resource_group_tags = {
  component = "resource-groups"
  cost_code = "RG-001"
}

# Key Vault Tags
key_vault_tags = {
  component = "key-vault"
  data_type = "secrets"
}

# NSG Tags
nsg_tags = {
  component = "network-security"
  function  = "traffic-filtering"
}

# Network Tags
network_tags = {
  component = "network"
  topology  = "hub-vnet"
}

# VPN Tags
vpn_tags = {
  component      = "vpn-gateway"
  connectionType = "site-to-site"
}

# Storage Tags
storage_tags = {
  component  = "storage"
  data_class = "general"
  encrypted  = "cmk"
}

# VM Tags
vm_tags = {
  component       = "virtual-machine"
  role            = "nas-archive-uploader"
  os_type         = "linux"
  patching_policy = "automatic"
  backup_enabled  = "false"
}

# Key Vault
key_vault_name                       = "Enter-Information"
key_vault_secret_vpn_shared_key_name = "VPN-Shared-Key"
key_vault_secret_vm_disk_key         = "VM-Disk-Key"
key_vault_sku                        = "premium"
soft_delete_retention_days           = 90
purge_protection                     = true
public_network_access_enabled        = false
rbac_authorization_enabled           = true

# NSG
nsg_name = "Network-Secuirty-Group-1"

cloud_cidr                           = "Enter-Information"
on_prem_public_ip                    = "Enter-Information"
on_prem_address_space                = "Enter-Information"
storage_private_endpoint_subnet_cidr = "Enter-Information"
dns_servers_cidr                     = ["168.63.129.16/32"]

# Network
vnet_name        = "uk-vnet-prod"
public_ip_name   = "public-ip-gateway"
vm_address_space = ["10.1.0.0/16"]

vm_subnet_name = "vm-subnet"
vm_subnet_cidr = "10.1.1.0/24"

private_endpoint_subnet_name = "private-endpoint-subnet"
private_endpoint_subnet_cidr = "10.1.2.0/24"

gateway_subnet_name = "subnet-gateway"
gateway_subnet_cidr = "10.1.255.0/27"

# VPN
vpn_gateway_name            = "vpn-gateway-SSI"
public_ip_allocation_method = "Dynamic"
public_ip_sku               = "Basic"

network_vpn_gateway_type = "Vpn"
vpn_gateway_type         = "RouteBased"
vpn_sku                  = "VpnGw1"

on_prem_gateway_name = "on-prem-gateway"

vpn_name = "Site-To-Site-Connection"
vpn_type = "IPsec"

# Storage
storage_account_name = "ENTER-INFORMATION"
blob_container_name  = "ENTER-INFORMATION"
archive_days         = 60

# VM
vm_name = "backup-linux"
vm_size = "Standard_B1s"

admin_username      = "azureuser"
ssh_public_key_path = "C:/.ssh/ENTER-INFORMATION.pub"

# NAS mount
nas_host     = "ENTER-INFORMATION"
nas_share    = "ENTER-INFORMATION"
