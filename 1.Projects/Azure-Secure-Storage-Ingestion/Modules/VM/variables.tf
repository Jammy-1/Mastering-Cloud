variable "vm_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

variable "vm_size" { type    = string }

variable "vm_subnet_id" { type = string }

variable "admin_username" { type = string }
variable "ssh_public_key_path" { type = string }


variable "nas_host" { type = string }
variable "nas_share" { type = string }
variable "nas_username" { type = string }
variable "nas_password" { type = string }
variable "key_vault_name" { type = string }

variable "storage_account_name" {type = string }
variable "blob_container_name" { type = string }
