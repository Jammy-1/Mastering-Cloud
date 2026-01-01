# Azure Location & Resource Group
variable "location"             { type = string }
variable "resource_group_name"  { type = string }

# AVD Host Pool
variable "host_pool_name"       { type = string }
variable "host_pool_type"       { type = string }
variable "load_balancer_type"   { type = string }
variable "application_group_name"{ type = string }
variable "workspace_name"       { type = string }

# VMSS
variable "vmss_name_prefix"       { type = string }
variable "vmss_sku"               { type = string}
variable "initial_instance_count" { type = number }
variable "min_instance_count"     { type = number }
variable "max_instance_count"     { type = number }
variable "vmss_os_disk_size_gb"   { type = number }
variable "vmss_os_disk_type"      { type = string }
variable "vmss_image_publisher"   { type = string }
variable "vmss_image_offer"       { type = string }
variable "vmss_image_sku"         { type = string }
variable "vmss_image_version"     { type = string }

variable "admin_username"       { type = string }
variable "admin_password"       { type = string }
variable "avd_subnet_id"        { type = string }
variable "aad_tenant_id"        { type = string }
variable "mdm_enrollment_id"    { type = string }

#FXLogix
variable "fslogix_storage_account" { type = string }
variable "fslogix_file_share" { type = string }