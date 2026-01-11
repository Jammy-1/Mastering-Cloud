# Event Hub NameSpace
resource "azurerm_eventhub_namespace" "this" {
  name                = var.eventhub_namespace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

# Event Hub
resource "azurerm_eventhub" "this" {
  name         = var.eventhub_name
  namespace_id = azurerm_eventhub_namespace.this.id

  partition_count   = 2
  message_retention = 1
}

# Rule
resource "azurerm_eventhub_namespace_authorization_rule" "this" {
  name                = var.eventhub_auth_rule_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}