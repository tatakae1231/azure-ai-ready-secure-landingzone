variable "share_name" { type = string }
variable "storage_account_name" { type = string }
variable "quota_in_gb" { type = number; default = 512 }
variable "enabled_protocol" { type = string; default = "SMB" }
variable "access_tier" { type = string; default = "Hot" }
