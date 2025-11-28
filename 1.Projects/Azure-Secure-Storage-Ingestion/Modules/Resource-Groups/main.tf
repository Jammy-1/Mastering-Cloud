resource "azurerm_resource_group" "core" {
  name     = var.rg_core_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "network" {
  name     = var.rg_network_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "compute" {
  name     = var.rg_compute_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "storage" {
  name     = var.rg_storage_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "security" {
  name     = var.rg_security_name
  location = var.location
  tags     = var.tags
}
