variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "security_rules" {
  type    = map(any)
  default = {}
}
