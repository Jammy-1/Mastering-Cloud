resource "azurerm_virtual_desktop_host_pool" "this" {
  name                       = var.host_pool_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  type                       = var.host_pool_type   
  load_balancer_type         = var.load_balancer_type  
  preferred_app_group_type   = "Desktop"
  maximum_sessions_allowed   = 10
  friendly_name              = var.host_pool_name
  description                = "Terraform AVD Host Pool (Azure AD join)"
}

resource "azurerm_virtual_desktop_application_group" "desktop" {
  name                 = var.application_group_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  type                 = "Desktop"
  host_pool_id         = azurerm_virtual_desktop_host_pool.this.id
}

resource "azurerm_virtual_desktop_workspace" "this" {
  name                 = var.workspace_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  friendly_name        = var.workspace_name
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "assoc" {
  workspace_id         = azurerm_virtual_desktop_workspace.this.id
  application_group_id = azurerm_virtual_desktop_application_group.desktop.id
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "this" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.this.id
  expiration_date = timeadd(timestamp(), "4h")
}

