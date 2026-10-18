output "landing_zones_mg_id" {
  value       = azurerm_management_group.landing_zones.id
  description = "ID of the Enterprise Landing Zones management group."
}

output "platform_mg_id" {
  value       = azurerm_management_group.platform.id
  description = "ID of the Platform management group."
}

output "ai_workloads_mg_id" {
  value       = azurerm_management_group.ai_workloads.id
  description = "ID of the AI Workloads management group. Used for policy scoping."
}

output "connectivity_mg_id" {
  value       = azurerm_management_group.connectivity.id
  description = "ID of the Connectivity management group."
}
