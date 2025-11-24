output "public_ip" {
  description = "Public IP address of the Load Balancer"
  value       = azurerm_public_ip.this.ip_address
}

output "backend_address_pool_id" {
  description = "Backend pool ID for the Load Balancer"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "ssh_nat_pool_start_port" {
  description = "Starting port of SSH NAT pool"
  value       = azurerm_lb_nat_pool.ssh.frontend_port_start
}

output "ssh_nat_pool_end_port" {
  description = "Ending port of SSH NAT pool"
  value       = azurerm_lb_nat_pool.ssh.frontend_port_end
}
