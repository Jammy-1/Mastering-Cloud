# General
resource_group_name = "Azure-VMSS-Web-Multi-Region-MultiAZ-Production"
location            = "uksouth"

# Storage 
storage_account_name   = "prodtfstatestoragemstf"
storage_container_name = "prodtfstatecontainermstf"
state_key_backend      = "backend/terraform.tfstate"
state_key_deployment   = "production/terraform.tfstate"

# Event Hub 
eventhub_namespace      = "website-namespace-mstf-production"
eventhub_name           = "storage-hub-mstf-production"
eventhub_auth_rule_name = "event-auth-rule-production"

# Environment Tags
env_tags = {
  environment = "production-backend"
  project     = "production-static-web-site"
  owner       = "production-backend-team"
  cost_center = "production-static-web-site"
}

# Backend Tags
backend_tags = {
  project_backend       = "prod-static-web-site-backend"
  managed_by            = "terraform"
  purpose               = "terraform-state"
  cost_center_secondary = "prod-static-web-site-backend"
  lifecycle             = "long-lived"
  criticality           = "high"
  backup_required       = "true"
}