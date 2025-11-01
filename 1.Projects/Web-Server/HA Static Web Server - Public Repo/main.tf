module "rg" {
  source   = "./modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.rg.name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
}

module "lb" {
  source              = "./modules/load-balancer"
  resource_group_name = module.rg.name
  location            = var.location
  public_ip_name      = var.public_ip_name
}


module "vmss" {
  source                     = "./modules/vmss"
  resource_group_name        = module.rg.name
  location                   = var.location
  subnet_id                  = module.network.subnet_id
  lb_backend_address_pool_id = module.lb.backend_address_pool_id
  
  vm_admin_username = var.vm_admin_username
  vm_admin_ssh_key  = file(var.ssh_public_key_path)
  instance_count    = var.instance_count
  vm_size           = var.vm_size

  github_repo   = var.github_repo
  github_branch = var.github_branch
  github_private = false
  github_deploy_key = ""
}


