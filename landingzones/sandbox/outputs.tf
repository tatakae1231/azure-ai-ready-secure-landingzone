output "resource_group_name" {
  value = azurerm_resource_group.sandbox_rg.name
}

output "sandbox_openai_endpoint" {
  value = module.sandbox_ai_services.endpoint
}
