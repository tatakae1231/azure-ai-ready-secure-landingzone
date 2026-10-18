variable "environment" {
  type        = string
  description = "Target environment name (e.g., dev, test, uat, prod)."
}

variable "location" {
  type        = string
  description = "Azure region for the data platform deployment."
}

variable "networking" {
  type = object({
    data_spoke_vnet_cidr = string
  })
  description = "CIDR block definition for the data platform spoke VNet."
}

variable "search_sku" {
  type        = string
  description = "The SKU of the Azure AI Search service (e.g., standard, storage-optimized)."
  default     = "standard"
}

variable "base_tags" {
  type        = map(string)
  description = "Base tags inherited from enterprise shared standards."
  default     = {}
}
