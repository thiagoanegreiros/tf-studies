locals {
  # Simulate optional values
  primary   = null
  fallback1 = ""
  fallback2 = "default-value"

  # coalesce returns the first non-null, non-empty string
  selected_value = coalesce(local.primary, local.fallback1, local.fallback2)

  # Numeric example
  number1 = null
  number2 = 0
  number3 = 42
  first_valid_number = coalesce(local.number1, local.number2, local.number3)
}

output "selected_value" {
  value = local.selected_value  # → "default-value"
}

output "first_valid_number" {
  value = local.first_valid_number  # → 0
}
