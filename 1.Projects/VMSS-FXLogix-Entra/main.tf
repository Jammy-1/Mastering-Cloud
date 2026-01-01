# Resource Group
module "rg" {
  source   = "./modules/resource-group"
  name     = var.resource_group_name
  location = var.location
}

# Network
module "network" {
  source              = "./modules/network"
  resource_group_name = module.rg.name
  location            = module.rg.location
  vnet_name           = var.vnet_name
  address_spaces      = var.vnet_address_spaces

  subnets = var.subnets
}


# NSG
module "nsg" {
  source              = "./modules/nsg"
  name                = var.nsg_name
  resource_group_name = module.rg.name
  location            = module.rg.location
  security_rules      = var.security_rules
}

# Attach NSG to AVD Subnet
resource "azurerm_subnet_network_security_group_association" "avd" {
  subnet_id                 = module.network.subnet_ids["AVD-Subnet"]
  network_security_group_id = module.nsg.id
}


# AVD
module "avd" {
  source = "./modules/avd"

  resource_group_name = module.rg.name
  location            = module.rg.location

  # Host Pool
  host_pool_name = var.host_pool_name
  host_pool_type = var.host_pool_type

  application_group_name = var.application_group_name
  workspace_name         = var.workspace_name

  # Network
  load_balancer_type = var.load_balancer_type
  avd_subnet_id      = module.network.subnet_ids["AVD-Subnet"]

  # VMSS
  vmss_name_prefix = var.vmss_name_prefix
  vmss_sku         = var.vmss_sku

  admin_username = var.admin_username
  admin_password = var.admin_password

  initial_instance_count = var.initial_instance_count
  min_instance_count     = var.min_instance_count
  max_instance_count     = var.max_instance_count
  vmss_os_disk_size_gb   = var.vmss_os_disk_size_gb
  vmss_os_disk_type      = var.vmss_os_disk_type
  vmss_image_publisher   = var.vmss_image_publisher
  vmss_image_offer       = var.vmss_image_offer
  vmss_image_sku         = var.vmss_image_sku
  vmss_image_version     = var.vmss_image_version

  aad_tenant_id     = var.aad_tenant_id
  mdm_enrollment_id = var.mdm_enrollment_id


  fslogix_storage_account = var.fslogix_storage_account
  fslogix_file_share      = var.fslogix_file_share
}

# FXLogix
module "fslogix" {
  source                  = "./modules/fslogix"
  resource_group_name     = module.rg.name
  location                = module.rg.location
  fslogix_storage_account = var.fslogix_storage_account
  fslogix_file_share      = var.fslogix_file_share
  fslogix_vhdx_size_gb    = var.fslogix_vhdx_size_gb

  vmss_id           = module.avd.vmss_id
  vmss_principal_id = module.avd.vmss_principal_id
}
