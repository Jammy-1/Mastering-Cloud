# General
resource_group_name = "Azure-VMSS-Web-Multi-Region-MultiAZ-Development"
location            = "uksouth"

# Storage 
storage_account_name   = "devtfstatestoragemstf"
storage_container_name = "devtfstatecontainermstf"
state_key_backend      = "backend/terraform.tfstate"
state_key_deployment   = "development/terraform.tfstate"

# Event Hub 
eventhub_namespace      = "website-namespace-mstf-development"
eventhub_name           = "storage-hub-mstf-development"
eventhub_auth_rule_name = "event-auth-rule-development"

# Environment Tags
env_tags = {
  environment = "development-backend"
  project     = "development-static-web-site"
  owner       = "development-backend-team"
  cost_center = "development-static-web-site"
}

# Backend Tags
backend_tags = {
  project_backend       = "dev-static-web-site-backend"
  managed_by            = "terraform"
  purpose               = "terraform-state"
  cost_center_secondary = "dev-static-web-site-backend"
  lifecycle             = "long-lived"
  criticality           = "high"
  backup_required       = "true"
}