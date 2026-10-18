locals {
  name_prefix = "slz-${var.environment}-${var.location}"
  common_tags = merge(
    var.base_tags,
    {
      Environment = var.environment
      LandingZone = "Data-Platform"
    }
  )
}

# 1. Resource Group for Data Platform
resource "azurerm_resource_group" "data_rg" {
  name     = "rg-${local.name_prefix}-data-platform-01"
  location = var.location
  tags     = local.common_tags
}

# 2. Data Spoke VNet
module "data_spoke_vnet" {
  source              = "../../modules/networking/vnet"
  vnet_name           = "vnet-${local.name_prefix}-data-spoke-01"
  resource_group_name = azurerm_resource_group.data_rg.name
  location            = azurerm_resource_group.data_rg.location
  address_space       = [var.networking.data_spoke_vnet_cidr]

  subnets = {
    "snet-data-compute" = {
      address_prefixes = [cidrsubnet(var.networking.data_spoke_vnet_cidr, 3, 0)]
    }
    "snet-data-endpoints" = {
      address_prefixes = [cidrsubnet(var.networking.data_spoke_vnet_cidr, 3, 1)]
    }
  }

  tags = local.common_tags
}

# 3. Enterprise Data Lake Storage Gen2 (ADLS Gen2)
module "data_lake" {
  source                        = "../../modules/storage/storage-account"
  storage_account_name          = "st${var.environment}datalake01" # Must be globally unique, lowercase alphanumeric
  resource_group_name           = azurerm_resource_group.data_rg.name
  location                      = azurerm_resource_group.data_rg.location
  account_tier                  = "Standard"
  account_replication_type      = var.environment == "prod" ? "GRS" : "LRS"
  is_hns_enabled                = true # Hierarchical Namespace for big data / AI ingestion
  public_network_access_enabled = false
  allowed_subnet_ids            = [module.data_spoke_vnet.subnet_ids["snet-data-compute"]]

  tags = local.common_tags
}

# 4. Containers for Structured AI Data Lake Zones
module "container_raw" {
  source               = "../../modules/storage/container"
  container_name       = "raw-ingestion"
  storage_account_name = module.data_lake.name
}

module "container_processed" {
  source               = "../../modules/storage/container"
  container_name       = "processed-features"
  storage_account_name = module.data_lake.name
}

module "container_vectors" {
  source               = "../../modules/storage/container"
  container_name       = "vector-embeddings"
  storage_account_name = module.data_lake.name
}

# 5. Azure AI Search Service for RAG Semantic Grounding
resource "azurerm_search_service" "ai_search" {
  name                          = "srch-${local.name_prefix}-rag-01"
  resource_group_name           = azurerm_resource_group.data_rg.name
  location                      = azurerm_resource_group.data_rg.location
  sku                           = var.search_sku
  replica_count                 = var.environment == "prod" ? 2 : 1
  partition_count               = 1
  public_network_access_enabled = false
  local_authentication_enabled  = false # Enforces Azure Entra ID RBAC

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

# 6. Private Endpoints for Zero-Trust Connectivity
module "pe_datalake_blob" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-st-${local.name_prefix}-dl-blob"
  resource_group_name            = azurerm_resource_group.data_rg.name
  location                       = azurerm_resource_group.data_rg.location
  subnet_id                      = module.data_spoke_vnet.subnet_ids["snet-data-endpoints"]
  private_connection_resource_id = module.data_lake.id
  subresource_names              = ["blob"]
  tags                           = local.common_tags
}

module "pe_datalake_dfs" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-st-${local.name_prefix}-dl-dfs"
  resource_group_name            = azurerm_resource_group.data_rg.name
  location                       = azurerm_resource_group.data_rg.location
  subnet_id                      = module.data_spoke_vnet.subnet_ids["snet-data-endpoints"]
  private_connection_resource_id = module.data_lake.id
  subresource_names              = ["dfs"]
  tags                           = local.common_tags
}

module "pe_ai_search" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-srch-${local.name_prefix}-rag"
  resource_group_name            = azurerm_resource_group.data_rg.name
  location                       = azurerm_resource_group.data_rg.location
  subnet_id                      = module.data_spoke_vnet.subnet_ids["snet-data-endpoints"]
  private_connection_resource_id = azurerm_search_service.ai_search.id
  subresource_names              = ["searchService"]
  tags                           = local.common_tags
}
