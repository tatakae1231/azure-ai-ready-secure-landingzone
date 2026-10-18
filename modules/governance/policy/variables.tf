variable "name" { type = string }
variable "display_name" { type = string }
variable "description" { type = string; default = "" }
variable "scope" { type = string; description = "Scope of the assignment (Management Group ID, Subscription ID, or Resource Group ID)." }
variable "resource_group_id" { type = string; default = null }
variable "policy_definition_id" { type = string }
variable "parameters" { type = string; default = null }
