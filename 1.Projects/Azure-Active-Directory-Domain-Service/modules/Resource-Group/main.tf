resource "azurerm_resource_group" "RG-AADS" {
  name     = var.resource_group
  location = var.location
}
