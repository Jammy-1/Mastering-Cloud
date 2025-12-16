# General 
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

# VMSS Tags
variable "vmss_tags" { type = map(string) }

# Network
variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }
variable "subnet_name" { type = string }
variable "subnet_prefix" { type = string }

variable "public_ip_name" { type = string }

# VMSS 
variable "vm_admin_username" { type = string }
variable "ssh_public_key_path" { type = string }
variable "instance_count" { type = number }
variable "vm_size" { type = string }

# Github
variable "github_repo" { type = string }
variable "github_branch" { type = string }
variable "github_private" { type = bool }