resource "azurerm_security_center_subscription_pricing" "this" {
  for_each      = var.defender_plans
  tier          = each.value.tier
  resource_type = each.key
  subplan       = lookup(each.value, "subplan", null)
}
