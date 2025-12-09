# Managed Identity 
resource "azurerm_user_assigned_identity" "storage_identity" {
  name                = "${var.storage_account_name}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled = false

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.storage_identity.id]
  }

  customer_managed_key {
    user_assigned_identity_id = azurerm_user_assigned_identity.storage_identity.id
    key_vault_key_id = var.key_vault_key_id
  }
  
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.network_subnet_id]
    bypass                     = ["AzureServices"]
  }

  tags = var.tags
}

# Private Endpoint for Storage
resource "azurerm_private_endpoint" "storage_pe" {
  name                = "${var.storage_account_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.network_subnet_id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

# Private DNS Zone for Storage
resource "azurerm_private_dns_zone" "storage_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_dns_link" {
  name                  = "storage-dns-link"
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  private_dns_zone_name = azurerm_private_dns_zone.storage_dns.name
}

# Blob Container for Backup
resource "azurerm_storage_container" "backup_container" {
  name                 = var.blob_container_name
  storage_account_id   = azurerm_storage_account.storage.id
  container_access_type = "private"
}

# Lifecycle Management Policy to Archive Data
resource "azurerm_storage_management_policy" "archive_policy" {
  storage_account_id = azurerm_storage_account.storage.id

  rule {
    name    = "MoveToArchive"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_archive_after_days_since_modification_greater_than = var.archive_days
      }
    }
  }
}
