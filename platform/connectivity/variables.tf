variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for hub connectivity resources."
  default     = "rg-az-ai-slz-connectivity"
}

variable "location" {
  type        = string
  description = "Azure region for deployment."
  default     = "southeastasia"
}

variable "hub_vnet_address_space" {
  type        = list(string)
  description = "Address space for the Hub Virtual Network."
  default     = ["10.100.0.0/16"]
}

variable "tags" {
  type        = map(string)
  description = "Default resource tags."
  default = {
    Environment = "Platform"
    LandingZone = "Connectivity"
  }
}
