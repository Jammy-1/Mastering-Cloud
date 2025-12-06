# Resource Groups
module "resource_groups" {
  source   = "./Modules/Resource-Groups"
  location = var.location

  rg_core_name     = var.rg_core_name
  rg_network_name  = var.rg_network_name
  rg_compute_name  = var.rg_compute_name
  rg_storage_name  = var.rg_storage_name
  rg_security_name = var.rg_security_name

  tags = var.tags
}

# NSG
module "nsg" {
  source              = "./Modules/NSG"
  nsg_name            = var.nsg_name
  resource_group_name = var.rg_network_name
  location            = var.location

  cloud_cidr                           = var.cloud_cidr
  on_prem_cidr                         = var.on_prem_cidr
  storage_private_endpoint_subnet_cidr = var.storage_private_endpoint_subnet_cidr
  security_rules                       = []

  tags = var.tags
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

  tags = var.tags
}
