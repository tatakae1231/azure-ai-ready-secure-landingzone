output "assigned_plans" { value = { for k, v in azurerm_security_center_subscription_pricing.this : k => v.tier } }
