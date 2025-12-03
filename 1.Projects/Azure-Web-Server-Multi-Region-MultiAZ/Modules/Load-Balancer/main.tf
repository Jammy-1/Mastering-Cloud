# Public IP
resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer
resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

# Backend Pool Address Pool
resource "azurerm_lb_backend_address_pool" "this" {
  name            = "backend-pool-${var.location}"
  loadbalancer_id = azurerm_lb.this.id
}

# Probe
resource "azurerm_lb_probe" "http" {
  name            = "http-probe-${var.location}"
  loadbalancer_id = azurerm_lb.this.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# Rules
resource "azurerm_lb_rule" "http" {
  name                           = "http-rule-${var.location}"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.http.id
  depends_on                     = [azurerm_lb.this]

}

