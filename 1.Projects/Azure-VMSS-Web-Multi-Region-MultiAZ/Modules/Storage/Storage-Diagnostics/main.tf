# Blob Logs
resource "azurerm_monitor_diagnostic_setting" "blob_logs" {
  name               = "${var.storage_account_name}-blob-logs"
  target_resource_id = "${var.storage_account_id}/blobServices/default"

  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_auth_rule_id

  enabled_log { category = "StorageRead" }
  enabled_log { category = "StorageWrite" }
  enabled_log { category = "StorageDelete" }


  enabled_metric { category = "AllMetrics" }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
