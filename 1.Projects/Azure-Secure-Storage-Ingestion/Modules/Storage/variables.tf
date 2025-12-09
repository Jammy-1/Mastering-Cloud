variable "storage_account_name" { type        = string}
variable "resource_group_name" { type        = string }
variable "location" { type        = string }
variable "tags" { type        = map(string) }

variable "network_subnet_id" { type        = string }
variable "virtual_network_id" { type        = string }

variable "key_vault_key_id" { type        = string  }
variable "blob_container_name" { type = string }

variable "archive_days" {
  type        = number 
  default     = 30 
}



