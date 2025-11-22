variable "host_pool_name" {
  type        = string
  description = "Name of the AVD host pool"
}

variable "host_pool_type" {
  type        = string
  description = "Type of AVD host pool: 'Pooled' or 'Personal'"
  default     = "Pooled"
}

variable "load_balancer_type" {
  type        = string
  description = "Load balancer type for AVD host pool: 'BreadthFirst' or 'DepthFirst'"
  default     = "BreadthFirst"
}

variable "application_group_name" {
  type        = string
  description = "Name of the AVD application group (Desktop)"
}

variable "workspace_name" {
  type        = string
  description = "Name of the AVD workspace"
}

variable "location" {
  type        = string
  description = "Azure location where resources will be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where AVD resources will be deployed"
}

variable "initial_instance_count" {
  type        = number
  description = "Initial number of VMs in the VMSS"
  default     = 2
}

variable "min_instance_count" {
  type        = number
  description = "Minimum number of VMs in VMSS for autoscale"
  default     = 2
}

variable "max_instance_count" {
  type        = number
  description = "Maximum number of VMs in VMSS for autoscale"
  default     = 10
}

variable "admin_username" {
  type        = string
  description = "Administrator username for VMSS VMs"
}

variable "admin_password" {
  type        = string
  description = "Administrator password for VMSS VMs"
  sensitive   = true
}

variable "avd_subnet_id" {
  type        = string
  description = "Subnet ID for the VMSS deployment"
}


variable "fslogix_storage_account" {
  type        = string
  description = "Name of the storage account used for FSLogix profile containers"
}

variable "fslogix_file_share" {
  type        = string
  description = "File share name in the storage account where FSLogix profiles will be stored"
  default     = "profiles"
}

variable "fslogix_vhdx_size_gb" {
  type        = number
  description = "Maximum size of each FSLogix profile container in GB"
  default     = 50
}


