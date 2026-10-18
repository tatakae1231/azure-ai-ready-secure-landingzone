variable "storage_account_id" { type = string }
variable "rule_name" { type = string; default = "ai-data-lifecycle-rule" }
variable "blob_types" { type = list(string); default = ["blockBlob"] }
variable "prefix_match" { type = list(string); default = [] }
variable "cool_after_days" { type = number; default = 30 }
variable "archive_after_days" { type = number; default = 90 }
variable "delete_after_days" { type = number; default = 365 }
variable "snapshot_delete_after_days" { type = number; default = 30 }
