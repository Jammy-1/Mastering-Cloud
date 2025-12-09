variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }


variable "vm_subnet_name" { type = string }
variable "vm_subnet_cidr" { type = string }

variable "private_endpoint_subnet_name" { type = string }
variable "private_endpoint_subnet_cidr" { type = string }

variable "gateway_subnet_name" { type = string }
variable "gateway_subnet_cidr" { type = string }

variable "nsg_id" { type = string }
variable "attach_nsg_to_vm_subnet" {
  type    = bool
  default = true
}