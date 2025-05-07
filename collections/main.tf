terraform {
  required_version = ">= 0.12"
}

locals {
  # Sample list and map
  fruits     = ["apple", "banana", "cherry"]
  nested     = [["a", "b"], ["c"]]
  fruit_map  = { apple = 1, banana = 2, cherry = 3 }
  map1       = { a = 1, b = 2 }
  map2       = { b = 3, c = 4 }

  # contains()
  has_banana = contains(local.fruits, "banana")

  # flatten()
  flattened = flatten(local.nested)

  # reverse()
  reversed_fruits = reverse(local.fruits)

  # keys() and values()
  fruit_keys   = keys(local.fruit_map)
  fruit_values = values(local.fruit_map)

  # merge()
  merged_map = merge(local.map1, local.map2)

  # zipmap()
  keys_list = ["name", "age"]
  values_list = ["Alice", "30"]
  zipped = zipmap(local.keys_list, local.values_list)

  # lookup()
  apple_value   = lookup(local.fruit_map, "apple", 0)
  unknown_value = lookup(local.fruit_map, "orange", 0)

  values_from_list_comprehension = [for k in keys(local.fruit_map) : local.fruit_map[k]]
}

output "values_from_list_comprehension" {
  value = local.values_from_list_comprehension
}

output "has_banana" {
  value = local.has_banana
}

output "flattened" {
  value = local.flattened
}

output "reversed_fruits" {
  value = local.reversed_fruits
}

output "fruit_keys" {
  value = local.fruit_keys
}

output "fruit_values" {
  value = local.fruit_values
}

output "merged_map" {
  value = local.merged_map
}

output "zipped_map" {
  value = local.zipped
}

output "apple_value" {
  value = local.apple_value
}

output "unknown_value" {
  value = local.unknown_value
}
