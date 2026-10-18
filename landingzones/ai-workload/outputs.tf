# landingzones/ai-workload/outputs.tf
output "resource_group_name" {
  value = azurerm_resource_group.ai_rg.name
}

output "ai_spoke_vnet_id" {
  value = module.ai_spoke_vnet.vnet_id
}

output "openai_endpoint" {
  value = module.ai_services.endpoint
}

output "storage_account_name" {
  value = module.ai_storage.name
}
