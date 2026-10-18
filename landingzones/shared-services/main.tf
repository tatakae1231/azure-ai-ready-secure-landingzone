locals {
  name_prefix = "slz-${var.environment}-${var.location}"
  common_tags = merge(var.base_tags, {
    Environment = var.environment
    LandingZone = "Shared-Services"
  })
}

# 1. Resource Group
resource "azurerm_resource_group" "shared_rg" {
  name     = "rg-${local.name_prefix}-shared-01"
  location = var.location
  tags     = local.common_tags
}

# 2. Shared VNet
module "shared_vnet" {
  source              = "../../modules/networking/vnet"
  vnet_name           = "vnet-${local.name_prefix}-shared-01"
  resource_group_name = azurerm_resource_group.shared_rg.name
  location            = azurerm_resource_group.shared_rg.location
  address_space       = [var.networking.hub_vnet_cidr]

  subnets = {
    "snet-shared-endpoints" = {
      address_prefixes = [cidrsubnet(var.networking.hub_vnet_cidr, 3, 0)]
    }
  }
  tags = local.common_tags
}

# 3. Azure Container Registry (ACR) for Custom AI/Model Images
resource "azurerm_container_registry" "acr" {
  name                       = "acr${var.environment}shared01" # Must be globally unique
  resource_group_name        = azurerm_resource_group.shared_rg.name
  location                   = azurerm_resource_group.shared_rg.location
  sku                        = "Premium"
  admin_enabled              = false
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

# 4. Private Endpoint for ACR
module "pe_acr" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-acr-${local.name_prefix}"
  resource_group_name            = azurerm_resource_group.shared_rg.name
  location                       = azurerm_resource_group.shared_rg.location
  subnet_id                      = module.shared_vnet.subnet_ids["snet-shared-endpoints"]
  private_connection_resource_id = azurerm_container_registry.acr.id
  subresource_names              = ["registry"]
  tags                           = local.common_tags
}
