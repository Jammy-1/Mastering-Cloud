# General 
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "env_tags" { type = map(string) }

# Backend 
variable "storage_account_name" { type = string }
variable "storage_container_name" { type = string }
variable "state_key_backend" { type = string }
variable "backend_tags" { type = map(string) }

# Eventhub 
variable "eventhub_namespace" { type = string }
variable "eventhub_name" { type = string }
variable "eventhub_auth_rule_name" { type = string }

variable "enable_storage_diagnostics" {
  type    = bool
  default = false
}