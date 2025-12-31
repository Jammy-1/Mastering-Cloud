# Resource Group
module "RG" {
  source         = "./modules/resource-group"
  resource_group = var.resource_group
  location       = var.location
}

# Network
module "network" {
  source              = "./modules/Network"
  resource_group      = var.resource_group
  location            = var.location
  vnet_name           = var.vnet_name

  address_spaces      = var.address_spaces
  dns_servers         = var.dns_servers
  subnets             = var.subnets

  depends_on = [ module.RG ]
}


# NSG
module "nsg" {
  source              = "./modules/NSG"
  nsg_name            = var.nsg_name
  resource_group      = var.resource_group
  location            = var.location
  security_rules      = var.security_rules

  depends_on = [ module.RG ]
}

# Attach NSG
resource "azurerm_subnet_network_security_group_association" "nsg_subnet" {
  for_each = module.network.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = module.nsg.id
}

# AADS
module "Active-Directory-Domain-Service" {
  source                = "./modules/aads"
  resource_group        = var.resource_group
  location              = var.location

  aadds_name            = var.aadds_name
  domain_name           = var.domain_name
  sku                   = var.sku
  filtered_sync_enabled = var.filtered_sync_enabled

  subnet_id = module.network.subnet_ids["subnet-01-AADS"]  

  dc_admin_upn          = var.dc_admin_upn
  dc_admin_display_name = var.dc_admin_display_name
  dc_admin_password     = var.dc_admin_password

  additional_recipients = var.additional_recipients
  notify_dc_admins      = var.notify_dc_admins
  notify_global_admins  = var.notify_global_admins

  sync_kerberos_passwords = var.sync_kerberos_passwords
  sync_ntlm_passwords     = var.sync_ntlm_passwords
  sync_on_prem_passwords  = var.sync_on_prem_passwords
}