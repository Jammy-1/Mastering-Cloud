variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "zones" { type = list(string) }

variable "subnet_id" { type = string }
variable "lb_backend_address_pool_id" { type = string }

variable "vm_admin_username" { type = string }
variable "vm_admin_ssh_key" { type = string }
variable "instance_count" { type = number }
variable "vm_size" { type = string }

variable "github_repo" { type = string }
variable "github_branch" { type = string }
variable "github_private" { type = bool }
variable "github_deploy_key" { type = string }


