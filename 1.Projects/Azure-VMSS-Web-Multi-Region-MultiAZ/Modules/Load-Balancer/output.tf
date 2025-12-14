output "public_ip" { value = azurerm_public_ip.this.ip_address }
output "backend_address_pool_id" { value = azurerm_lb_backend_address_pool.this.id }
output "backend_address_pool_name" { value = azurerm_lb_backend_address_pool.this.name }

output "lb_name" {
  value = azurerm_lb.this.name
}