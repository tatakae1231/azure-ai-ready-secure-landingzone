locals {
  name_prefix = "slz-${var.environment}-${var.location}"
  common_tags = merge(
    var.base_tags,
    {
      Environment = var.environment
      LandingZone = "Sandbox"
      CostCenter  = "RND-Sandbox-Pool"
    }
  )
}

# 1. Resource Group for Sandbox
resource "azurerm_resource_group" "sandbox_rg" {
  name     = "rg-${local.name_prefix}-sandbox-01"
  location = var.location
  tags     = local.common_tags
}

# 2. Isolated Sandbox VNet
module "sandbox_vnet" {
  source              = "../../modules/networking/vnet"
  vnet_name           = "vnet-${local.name_prefix}-sandbox-01"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  address_space       = [var.networking.sandbox_vnet_cidr]

  subnets = {
    "snet-sandbox-compute" = {
      address_prefixes = [cidrsubnet(var.networking.sandbox_vnet_cidr, 3, 0)]
    }
    "snet-sandbox-endpoints" = {
      address_prefixes = [cidrsubnet(var.networking.sandbox_vnet_cidr, 3, 1)]
    }
  }

  tags = local.common_tags
}

# 3. Lightweight Key Vault (Short retention for rapid tear-down/rebuild cycles)
module "sandbox_key_vault" {
  source                     = "../../modules/security/key-vault"
  key_vault_name             = "kv-${local.name_prefix}-box-01"
  resource_group_name        = azurerm_resource_group.sandbox_rg.name
  location                   = azurerm_resource_group.sandbox_rg.location
  sku_name                   = "standard"
  soft_delete_retention_days = 7 # Shortened for sandbox cleanup
  purge_protection_enabled   = false # Allows immediate deletion during experimentation
  allowed_subnet_ids         = [module.sandbox_vnet.subnet_ids["snet-sandbox-compute"]]

  tags = local.common_tags
}

# 4. Standard Cost-Optimized Storage Account (LRS instead of GRS)
module "sandbox_storage" {
  source                       = "../../modules/storage/storage-account"
  storage_account_name         = "stboxdata01" # Note: Keep short, unique per naming convention
  resource_group_name          = azurerm_resource_group.sandbox_rg.name
  location                     = azurerm_resource_group.sandbox_rg.location
  account_tier                 = "Standard"
  account_replication_type     = "LRS" # Local redundancy to minimize sandbox costs
  is_hns_enabled               = true
  public_network_access_enabled = true # Permitted in sandbox for easier external prototyping
  soft_delete_retention_days   = 7
  allowed_subnet_ids           = [module.sandbox_vnet.subnet_ids["snet-sandbox-compute"]]

  tags = local.common_tags
}

# 5. Sandbox Azure OpenAI Account (Lower capacity / Standard tier)
module "sandbox_ai_services" {
  source                        = "../../modules/ai-services/cognitive-services"
  account_name                  = "cog-${local.name_prefix}-box-openai"
  resource_group_name           = azurerm_resource_group.sandbox_rg.name
  location                      = azurerm_resource_group.sandbox_rg.location
  kind                          = "OpenAI"
  sku_name                      = "S0"
  public_network_access_enabled = true # Allowed for developer testing convenience
  local_auth_enabled            = true # Allows API key usage for rapid prototyping

  model_deployments = {
    "gpt-4o-mini" = {
      format   = "OpenAI"
      name     = "gpt-4o-mini"
      version  = "2024-07-18"
      sku_name = "Standard"
      capacity = 5 # Restricted capacity to guard against runaway token spend
    }
  }

  tags = local.common_tags
}

# 6. Cost Guardian Guardrail (Azure Policy Assignment limiting expensive SKUs)
resource "azurerm_policy_assignment" "sandbox_cost_guardrail" {
  name                 = "pol-limit-expensive-skus-sandbox"
  resource_group_id    = azurerm_resource_group.sandbox_rg.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/df49AW92..." # Example built-in definition ID for SKU restrictions
  description          = "Prevents deployment of high-tier production GPUs and ultra-costly SKUs in the sandbox environment."
  display_name         = "Sandbox Cost & SKU Guardrail"
}
