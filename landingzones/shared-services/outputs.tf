output "resource_group_name" {
  value = azurerm_resource_group.shared_rg.name
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
