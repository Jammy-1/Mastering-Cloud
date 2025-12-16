# Resource Group
module "rg" {
  source   = "./modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Network
module "network" {
  source   = "./modules/network"
  for_each = { for r in local.deploy_regions : r.name => r }

  resource_group_name = module.rg.name
  location            = each.value.name
  vnet_name           = "vnet-${each.key}"
  address_space       = var.vnet_address_space
  subnet_name         = "subnet-${each.key}"
  subnet_prefix       = var.subnet_prefix
}

# Load Balancer
module "lb" {
  source   = "./modules/load-balancer"
  for_each = { for r in local.deploy_regions : r.name => r }

  resource_group_name = module.rg.name
  location            = each.value.name
  public_ip_name      = "public-lb-${each.key}"
  lb_name             = "web-lb-${each.key}"
}

# Regions
module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "0.9.2"
}

locals {
  primary_region = [
    for r in module.regions.regions : r
    if lower(r.name) == lower(var.location)
  ][0]

  paired_region = try([
    for r in module.regions.regions :
    r if r.name == local.primary_region.paired_region_name
  ][0], null)
  
  deploy_regions = (
    local.paired_region == null ?
    [local.primary_region] :
    [local.primary_region, local.paired_region]
  )

  region_zones = {
    for r in local.deploy_regions :
    r.name => (
      try(r.zones, null) != null && length(r.zones) > 0 ?
      r.zones : null
    )
  }
  deploy_matrix = {
    for r in local.deploy_regions :
    r.name => {
      region    = r.name
      zones     = lookup(local.region_zones, r.name, null)
      use_zones = lookup(local.region_zones, r.name, null) != null
    }
  }
}

# VMSS
module "vmss" {
  source              = "./modules/vmss"
  resource_group_name = module.rg.name
  tags                = var.vmss_tags
  for_each            = { for r in local.deploy_regions : r.name => r }

  zones    = lookup(local.region_zones, each.key, [])
  location = each.key

  subnet_id                  = module.network[each.key].subnet_id
  lb_backend_address_pool_id = module.lb[each.key].backend_address_pool_id


  vm_admin_username = var.vm_admin_username
  vm_admin_ssh_key  = file(var.ssh_public_key_path)
  instance_count    = var.instance_count
  vm_size           = var.vm_size

  github_repo       = var.github_repo
  github_branch     = var.github_branch
  github_private    = false
  github_deploy_key = ""

  depends_on = [module.lb]

}


