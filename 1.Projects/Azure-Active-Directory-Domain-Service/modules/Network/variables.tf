variable "vnet_name" { type = string }
variable "resource_group" { type = string }
variable "location" { type = string }
variable "address_spaces" { type = list(string) }
variable "dns_servers" { type = list(string) }

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    attach_nsg       = optional(bool, true)
  }))
}
