# General 
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

# Storage
variable "storage_account_name" { type = string }
variable "storage_container_name" { type = string }
variable "state_key_backend" { type = string }
