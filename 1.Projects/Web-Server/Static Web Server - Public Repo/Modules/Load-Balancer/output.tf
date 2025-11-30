output "public_ip" {
  description = "Public IP address of the Load Balancer"
  value       = azurerm_public_ip.this.ip_address
}

output "backend_address_pool_id" {
  description = "Backend pool ID for the Load Balancer"
  value       = azurerm_lb_backend_address_pool.this.id
}

