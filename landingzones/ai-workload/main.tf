# landingzones/ai-workload/main.tf

# 1. Resource Group for AI Workload Spoke
resource "azurerm_resource_group" "ai_rg" {
  name     = "rg-${local.name_prefix}-ai-workload-01"
  location = var.primary_location
  tags     = local.common_tags
}

# 2. AI Spoke Virtual Network
module "ai_spoke_vnet" {
  source              = "../../modules/networking/vnet"
  vnet_name           = "vnet-${local.name_prefix}-ai-spoke-01"
  resource_group_name = azurerm_resource_group.ai_rg.name
  location            = azurerm_resource_group.ai_rg.location
  address_space       = [var.networking.ai_spoke_vnet_cidr]

  subnets = {
    "snet-ai-compute" = {
      address_prefixes = [cidrsubnet(var.networking.ai_spoke_vnet_cidr, 3, 0)]
    }
    "snet-ai-endpoints" = {
      address_prefixes = [cidrsubnet(var.networking.ai_spoke_vnet_cidr, 3, 1)]
    }
  }

  tags = local.common_tags
}

# 3. Secure Key Vault for Model Secrets & API Keys
module "ai_key_vault" {
  source                     = "../../modules/security/key-vault"
  key_vault_name             = "kv-${local.name_prefix}-ai-01"
  resource_group_name        = azurerm_resource_group.ai_rg.name
  location                   = azurerm_resource_group.ai_rg.location
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = var.security_config.key_vault_purge_protection
  allowed_subnet_ids         = [module.ai_spoke_vnet.subnet_ids["snet-ai-compute"]]

  tags = local.common_tags
}

# 4. Secure Storage Account (Data Lake Gen2 for Training & Embeddings)
module "ai_storage" {
  source                       = "../../modules/storage/storage-account"
  storage_account_name         = "st${var.environment}aislz01" # Note: must be globally unique alphanumeric, handled via prefix/suffix convention
  resource_group_name          = azurerm_resource_group.ai_rg.name
  location                     = azurerm_resource_group.ai_rg.location
  account_tier                 = "Standard"
  account_replication_type     = var.environment == "prod" ? "GRS" : "LRS"
  is_hns_enabled               = true
  public_network_access_enabled = false
  allowed_subnet_ids           = [module.ai_spoke_vnet.subnet_ids["snet-ai-compute"]]

  tags = local.common_tags
}

# 5. Azure AI Services / OpenAI Account
module "ai_services" {
  source                        = "../../modules/ai-services/cognitive-services"
  account_name                  = "cog-${local.name_prefix}-openai-01"
  resource_group_name           = azurerm_resource_group.ai_rg.name
  location                      = azurerm_resource_group.ai_rg.location
  kind                          = "OpenAI"
  sku_name                      = var.ai_config.openai_sku
  public_network_access_enabled = false
  local_auth_enabled            = false # Enforces Entra ID authentication

  model_deployments = {
    "gpt-4o" = {
      format   = "OpenAI"
      name     = "gpt-4o"
      version  = "2024-05-13"
      sku_name = "Standard"
      capacity = 10
    }
    "text-embedding-3-small" = {
      format   = "OpenAI"
      name     = "text-embedding-3-small"
      version  = "1"
      sku_name = "Standard"
      capacity = 10
    }
  }

  allowed_subnet_ids = [module.ai_spoke_vnet.subnet_ids["snet-ai-compute"]]
  tags               = local.common_tags
}

# 6. Private Endpoints for Zero-Trust PaaS Access
module "pe_openai" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-cog-${local.name_prefix}-openai"
  resource_group_name            = azurerm_resource_group.ai_rg.name
  location                       = azurerm_resource_group.ai_rg.location
  subnet_id                      = module.ai_spoke_vnet.subnet_ids["snet-ai-endpoints"]
  private_connection_resource_id = module.ai_services.id
  subresource_names              = ["account"]

  tags = local.common_tags
}

module "pe_storage" {
  source                         = "../../modules/networking/private-endpoint"
  name                           = "pe-st-${local.name_prefix}-blob"
  resource_group_name            = azurerm_resource_group.ai_rg.name
  location                       = azurerm_resource_group.ai_rg.location
  subnet_id                      = module.ai_spoke_vnet.subnet_ids["snet-ai-endpoints"]
  private_connection_resource_id = module.ai_storage.id
  subresource_names              = ["blob"]

  tags = local.common_tags
}
