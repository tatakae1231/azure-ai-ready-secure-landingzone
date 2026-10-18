variable "environment" {
  type        = string
  description = "Target environment name (must be 'sandbox')."
  default     = "sandbox"
}

variable "location" {
  type        = string
  description = "Azure region for the sandbox deployment."
}

variable "networking" {
  type = object({
    sandbox_vnet_cidr = string
  })
  description = "CIDR block definition for the sandbox spoke VNet."
  default = {
    sandbox_vnet_cidr = "10.250.0.0/16"
  }
}

variable "base_tags" {
  type        = map(string)
  description = "Base tags inherited from enterprise shared standards."
  default     = {}
}
