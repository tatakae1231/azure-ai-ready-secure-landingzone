# environments/prod/main.tf
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

locals {
  config = yamldecode(file("${path.module}/config.yml"))
}

module "ai_secure_landing_zone" {
  source = "../../landingzones/ai-workload"

  environment           = local.config.environment
  primary_location      = local.config.location.primary
  secondary_location    = local.config.location.secondary
  networking            = local.config.networking
  ai_config             = local.config.azure_ai_services
  security_config       = local.config.security
}
