output "id" {
  description = "The ID of the Private Endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "The name of the Private Endpoint."
  value       = azurerm_private_endpoint.this.name
}

output "private_ip_address" {
  description = "The Private IP Address allocated to the Private Endpoint."
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}
