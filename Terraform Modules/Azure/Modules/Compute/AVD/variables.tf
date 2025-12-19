# General Azure Settings
variable "location"             { type = string }
variable "resource_group_name"  { type = string }

# AVD Host Pool
variable "host_pool_name"       { type = string }
variable "host_pool_type"       { type = string }
variable "load_balancer_type"   { type = string }
variable "application_group_name"{ type = string }
variable "workspace_name"       { type = string }
