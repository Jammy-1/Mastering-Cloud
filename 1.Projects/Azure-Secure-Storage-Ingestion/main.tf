# Resource Groups
module "resource_groups" {
  source   = "./Modules/Resource-Groups"
  location = var.location

  rg_core_name     = var.rg_core_name
  rg_network_name  = var.rg_network_name
  rg_compute_name  = var.rg_compute_name
  rg_storage_name  = var.rg_storage_name
  rg_security_name = var.rg_security_name

  tags = merge(var.global_tags, var.resource_group_tags)
}

# Key Vault
data "azurerm_client_config" "current" {}
module "key_vault" {
  source                        = "./modules/Key-Vault"
  key_vault_name                = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.rg_security_name
  key_vault_sku                 = var.key_vault_sku
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection              = var.public_network_access_enabled
  public_network_access_enabled = var.public_network_access_enabled
  rbac_authorization_enabled    = var.rbac_authorization_enabled

  vpn_shared_key                       = var.vpn_shared_key
  key_vault_secret_vpn_shared_key_name = var.key_vault_secret_vpn_shared_key_name
  key_vault_secret_vm_disk_key         = var.key_vault_secret_vm_disk_key
  nas_username                         = var.nas_username
  nas_password                         = var.nas_password

  storage_identity_principal_id = module.storage.identity_principal_id

  tags = merge(var.global_tags, var.key_vault_tags)
}

# NSG
module "nsg" {
  source              = "./Modules/NSG"
  nsg_name            = var.nsg_name
  resource_group_name = var.rg_network_name
  location            = var.location

  cloud_cidr                           = var.cloud_cidr
  on_prem_public_ip                    = var.on_prem_public_ip
  storage_private_endpoint_subnet_cidr = var.storage_private_endpoint_subnet_cidr
  security_rules                       = []

  tags = merge(var.global_tags, var.nsg_tags)
}

# Network
module "network" {
  source = "./modules/Network"

  resource_group_name = var.rg_network_name
  location            = var.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vm_address_space

  vm_subnet_name = var.vm_subnet_name
  vm_subnet_cidr = var.vm_subnet_cidr

  private_endpoint_subnet_name = var.private_endpoint_subnet_name
  private_endpoint_subnet_cidr = var.private_endpoint_subnet_cidr

  gateway_subnet_name = var.gateway_subnet_name
  gateway_subnet_cidr = var.gateway_subnet_cidr

  nsg_id                  = module.nsg.id
  attach_nsg_to_vm_subnet = true

  tags = merge(var.global_tags, var.network_tags)
}

# VPN 
module "vpn" {
  source              = "./modules/vpn"
  resource_group_name = var.rg_network_name
  location            = var.location
  
  public_ip_name              = var.public_ip_name
  public_ip_allocation_method = var.public_ip_allocation_method
  public_ip_sku               = var.public_ip_sku

  vpn_gateway_name         = var.vpn_gateway_name
  network_vpn_gateway_type = var.network_vpn_gateway_type
  vpn_gateway_type         = var.vpn_gateway_type
  vpn_sku                  = var.vpn_sku
  gateway_subnet           = module.network.gateway_subnet_id

  on_prem_gateway_name  = var.on_prem_gateway_name
  on_prem_public_ip     = var.on_prem_public_ip
  on_prem_address_space = var.on_prem_address_space

  vpn_name       = var.vpn_name
  vpn_type       = var.vpn_type
  vpn_shared_key = module.key_vault.vpn_shared_key_secret_value
  
  tags = merge(var.global_tags, var.vpn_tags)
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = var.storage_account_name
  resource_group_name  = var.rg_storage_name
  location             = var.location

  network_subnet_id    = module.network.private_endpoint_subnet_id
  virtual_network_id   = module.network.vnet_id

  key_vault_key_id    = module.key_vault.storage_cmk_key_id

  blob_container_name = var.blob_container_name
  archive_days        = var.archive_days

  tags = merge(var.global_tags, var.storage_tags)
}

# Linux VM
module "vm" {
  source = "./modules/vm"

  resource_group_name = var.rg_compute_name
  location            = var.location

  vm_name       = var.vm_name
  vm_size       = var.vm_size
  vm_subnet_id  = module.network.vm_subnet_id

  admin_username       = var.admin_username
  ssh_public_key_path  = var.ssh_public_key_path

  key_vault_name = var.key_vault_name
  nas_host     = var.nas_host
  nas_share    = var.nas_share
  nas_username = var.nas_username
  nas_password = var.nas_password

  storage_account_name = module.storage.storage_account_name
  blob_container_name  = module.storage.blob_container_name

  tags = merge(var.global_tags, var.vm_tags)
}
