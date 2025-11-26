variable "resource_group" { type = string }
variable "location" { type = string }

variable "aadds_name" { type = string }
variable "domain_name" { type = string }
variable "sku" { type = string }
variable "filtered_sync_enabled" { type = bool }

variable "subnet_id" { type = string }

variable "additional_recipients" { type = list(string) }
variable "notify_dc_admins" { type = bool }
variable "notify_global_admins" { type = bool }

variable "sync_kerberos_passwords" { type = bool }
variable "sync_ntlm_passwords" { type = bool }
variable "sync_on_prem_passwords" { type = bool }

variable "dc_admin_upn" { type = string }
variable "dc_admin_display_name" { type = string }
variable "dc_admin_password" { type = string }

