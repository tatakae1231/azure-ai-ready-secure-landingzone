output "hub_vnet_id" {
  value       = azurerm_virtual_network.hub.id
  description = "The ID of the Hub VNet."
}

output "azure_firewall_private_ip" {
  value       = azurerm_firewall.hub_fw.ip_configuration[0].private_ip_address
  description = "Private IP address of the Azure Firewall for UDR routing."
}

output "spoke_route_table_id" {
  value       = azurerm_route_table.spoke_forced_tunnel.id
  description = "Route table ID to attach to AI spoke VNets for forced tunneling."
}

output "private_dns_zone_ids" {
  value       = { for k, v in azurerm_private_dns_zone.dns_zones : k => v.id }
  description = "Map of created Private DNS Zone IDs."
}
