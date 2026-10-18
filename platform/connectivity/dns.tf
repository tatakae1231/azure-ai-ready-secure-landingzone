locals {
  private_dns_zones = [
    "privatelink.openai.azure.com",
    "privatelink.search.windows.net",
    "privatelink.cognitiveservices.azure.com",
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net"
  ]
}

# Create Private DNS Zones in Hub
resource "azurerm_private_dns_zone" "dns_zones" {
  for_each            = toset(local.private_dns_zones)
  name                = each.value
  resource_group_name = azurerm_resource_group.connectivity.name
  tags                = var.tags
}

# Link Private DNS Zones to Hub VNet
resource "azurerm_private_dns_zone_virtual_network_link" "hub_dns_link" {
  for_each              = azurerm_private_dns_zone.dns_zones
  name                  = "link-${each.value.name}-hub"
  resource_group_name   = azurerm_resource_group.connectivity.name
  private_dns_zone_name = each.value.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = false
  tags                  = var.tags
}
