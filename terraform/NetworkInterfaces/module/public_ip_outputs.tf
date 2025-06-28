locals {
ip_address = var.name == "No" ? null : azurerm_public_ip.publicIP.0.id
}

output "ip_address" {
  description = "ID of Subnet"
  value       = local.ip_address
}