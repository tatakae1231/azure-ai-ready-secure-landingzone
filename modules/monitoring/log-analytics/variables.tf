variable "workspace_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "sku" { type = string; default = "PerGB2018" }
variable "retention_in_days" { type = number; default = 365 } # Enforced for enterprise compliance
variable "daily_quota_gb" { type = number; default = -1 }
variable "tags" { type = map(string); default = {} }
