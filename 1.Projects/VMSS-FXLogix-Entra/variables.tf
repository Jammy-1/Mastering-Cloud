# General Settings
variable "resource_group_name" { type = string }
variable "location" { type = string }

# AVD
variable "host_pool_name" { type = string }
variable "host_pool_type" { type = string }
variable "load_balancer_type" { type = string }
variable "application_group_name" { type = string }
variable "workspace_name" { type = string }

# VMSS 
variable "admin_username" { type = string }

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "vmss_name_prefix" { type = string }
variable "vmss_sku" { type = string }
variable "initial_instance_count" { type = number }
variable "min_instance_count" { type = number }
variable "max_instance_count" { type = number }

variable "vmss_os_disk_size_gb" { type = number }
variable "vmss_os_disk_type" { type = string }

variable "vmss_image_publisher" { type = string }
variable "vmss_image_offer" { type = string }
variable "vmss_image_sku" { type = string }
variable "vmss_image_version" { type = string }

variable "aad_tenant_id" { type = string }
variable "mdm_enrollment_id" { type = string }


# FX Logix
variable "fslogix_storage_account" { type = string }
variable "fslogix_file_share" { type = string }
variable "fslogix_vhdx_size_gb" { type = number }

# Networking
variable "vnet_name" { type = string }
variable "vnet_address_spaces" { type = list(string) }
variable "nsg_name" { type = string }
variable "avd_subnet_id" { type = string }

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    attach_nsg       = bool
  }))
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

