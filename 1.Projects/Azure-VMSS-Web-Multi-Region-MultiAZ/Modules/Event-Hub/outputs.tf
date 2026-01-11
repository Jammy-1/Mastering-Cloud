# Outputs
output "eventhub_namespace_name" { value = azurerm_eventhub_namespace.this.name }
output "eventhub_name" { value = azurerm_eventhub.this.name }
output "eventhub_auth_rule_name" { value = azurerm_eventhub_namespace_authorization_rule.this.name }
output "eventhub_auth_rule_id" { value = azurerm_eventhub_namespace_authorization_rule.this.id }
