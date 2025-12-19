variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "fslogix_storage_account" { type = string }
variable "fslogix_file_share" { type = string }
variable "fslogix_vhdx_size_gb" { type = number }
variable "vmss_id" { type = string }
variable "vmss_principal_id" { type = string }