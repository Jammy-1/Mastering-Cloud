# Resource Group
module "resource-group" {
  source              = "../../../Modules/Resource-Group"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(var.env_tags, var.backend_tags)
}

# Event Hub 
module "event-hub" {
  source                  = "../../../Modules/Event-Hub"
  resource_group_name     = var.resource_group_name
  eventhub_name           = var.eventhub_name
  eventhub_namespace      = var.eventhub_namespace
  eventhub_auth_rule_name = var.eventhub_auth_rule_name
  location                = var.location
  tags                    = var.env_tags

  depends_on = [module.resource-group]
}

# Storage
module "storage" {
  source                 = "../../../Modules/Storage"
  resource_group_name    = var.resource_group_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  state_key_backend      = var.state_key_backend
  location               = var.location

  depends_on = [module.resource-group]

  tags = merge(var.env_tags, var.backend_tags)
}

module "storage-diagnostics" {
  source = "../../../Modules/Storage/Storage-Diagnostics"

  storage_account_id   = module.storage.storage_account_id
  storage_account_name = var.storage_account_name

  eventhub_name         = var.eventhub_name
  eventhub_namespace    = var.eventhub_namespace
  eventhub_auth_rule_id = module.event-hub.eventhub_auth_rule_id

  count = var.enable_storage_diagnostics ? 1 : 0
}