variable "name" {
  type        = string
  description = "Specifies the Name of the Private Endpoint."
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the Name of the Resource Group within which the Private Endpoint should exist."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the Private Endpoint exists."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."
}

variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to (e.g., 'account', 'vault')."
  default     = null
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of Private DNS Zone IDs to associate with the Private Endpoint."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
