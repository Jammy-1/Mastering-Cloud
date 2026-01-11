# General
resource_group_name = "Azure-VMSS-Web-Multi-Region-MultiAZ-Staging"
location            = "uksouth"

# Storage 
storage_account_name   = "stagetfstatestoragemstf"
storage_container_name = "stagetfstatestoragemstf"
state_key_backend      = "backend/terraform.tfstate"
state_key_deployment   = "staging/terraform.tfstate"

# Event Hub 
eventhub_namespace      = "website-namespace-mstf-staging"
eventhub_name           = "storage-hub-mstf-staging"
eventhub_auth_rule_name = "event-auth-rule-staging"

# Environment Tags
env_tags = {
  environment = "staging-backend"
  project     = "staging-static-web-site"
  owner       = "staging-backend-team"
  cost_center = "staging-static-web-site"
}

# Backend Tags
backend_tags = {
  project_backend       = "stage-static-web-site-backend"
  managed_by            = "terraform"
  purpose               = "terraform-state"
  cost_center_secondary = "stage-static-web-site-backend"
  lifecycle             = "long-lived"
  criticality           = "high"
  backup_required       = "true"
}