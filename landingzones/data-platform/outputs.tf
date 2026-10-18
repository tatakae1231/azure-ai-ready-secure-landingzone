output "resource_group_name" {
  value = azurerm_resource_group.data_rg.name
}

output "data_lake_name" {
  value = module.data_lake.name
}

output "ai_search_endpoint" {
  value = "https://${azurerm_search_service.ai_search.name}.search.windows.net"
}
