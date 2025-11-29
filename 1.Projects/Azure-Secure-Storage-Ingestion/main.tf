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
  security_rules      = var.security_rules

  tags = var.tags
}