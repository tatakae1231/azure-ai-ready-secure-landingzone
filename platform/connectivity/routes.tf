resource "azurerm_route_table" "spoke_forced_tunnel" {
  name                          = "rt-spoke-to-firewall"
  location                      = azurerm_resource_group.connectivity.location
  resource_group_name           = azurerm_resource_group.connectivity.name
  disable_bgp_route_propagation = false

  route {
    name                   = "default-to-azure-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.hub_fw.ip_configuration[0].private_ip_address
  }

  tags = var.tags
}
