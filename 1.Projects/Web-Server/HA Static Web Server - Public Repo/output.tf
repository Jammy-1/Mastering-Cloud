output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.rg.name
}

output "subnet_id" {
  description = "ID of the subnet used by the VMs"
  value       = module.network.subnet_id
}

output "backend_address_pool_id" {
  description = "Backend pool ID for the load balancer"
  value       = module.lb.backend_address_pool_id
}

output "vmss_id" {
  description = "ID of the VM Scale Set"
  value       = module.vmss.vmss_id
}

output "public_ip" {
  description = "Public IP address of the load balancer"
  value       = module.lb.public_ip
}
