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
  subnets             = var.subnets
}


# NSG
module "nsg" {
  source              = "./modules/NSG"
  nsg_name            = var.nsg_name
  resource_group      = var.resource_group
  location            = var.location
  security_rules      = var.security_rules
}

# Attach NSG
resource "azurerm_subnet_network_security_group_association" "nsg_subnet" {
  for_each = module.network.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = module.nsg.id
}


