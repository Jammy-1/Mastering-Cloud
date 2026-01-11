# General
resource_group_name = "Azure-VMSS-Web-Multi-Region-MultiAZ"
location            = "uksouth"

# Storage 
storage_account_name   = "bkndtfstatestoragemstf"
storage_container_name = "bkndtfstatestoragemstf"
state_key              = "backend/terraform.tfstate"

# Event Hub 
eventhub_namespace      = "website-namespace-mstf"
eventhub_name           = "storage-hub-mstf"
eventhub_auth_rule_name = "event-auth-rule"

# Environment Tags
env_tags = {
  environment = "backend"
  project     = "static-web-site"
  owner       = "backend-team"
  cost_center = "static-web-site"
}

# Backend Tags
backend_tags = {
  project_backend       = "static-web-site-backend"
  managed_by            = "terraform"
  purpose               = "terraform-state"
  cost_center_secondary = "static-web-site-backend"
  lifecycle             = "long-lived"
  criticality           = "high"
  backup_required       = "true"
}