variable "environment" {
  type        = string
  description = "Target environment name (e.g., shared, prod)."
}

variable "location" {
  type        = string
  description = "Azure region for shared services."
}

variable "networking" {
  type = object({
    hub_vnet_cidr = string
  })
  description = "CIDR block for the shared services VNet."
}

variable "base_tags" {
  type        = map(string)
  description = "Base tags inherited from enterprise shared standards."
  default     = {}
}
