# landingzones/ai-workload/variables.tf
variable "environment" {
  type        = string
  description = "Target environment name (e.g., dev, test, uat, prod)."
}

variable "primary_location" {
  type        = string
  description = "Primary Azure region for deployment."
}

variable "secondary_location" {
  type        = string
  description = "Secondary Azure region for multi-region HA (if applicable)."
  default     = null
}

variable "networking" {
  type = object({
    hub_vnet_cidr      = string
    ai_spoke_vnet_cidr = string
  })
  description = "CIDR block definitions for networking."
}

variable "ai_config" {
  type = object({
    openai_sku             = string
    enable_content_safety  = bool
    public_network_access  = string
  })
  description = "Configuration parameters for Azure AI services."
}

variable "security_config" {
  type = object({
    key_vault_purge_protection = bool
    log_retention_days         = int
  })
  description = "Security baseline parameters."
}

variable "base_tags" {
  type        = map(string)
  description = "Base tags inherited from enterprise shared standards."
  default     = {}
}
