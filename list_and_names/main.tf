terraform {
  required_version = ">= 0.12"
}

locals {
  # Simple list of strings
  names = ["thiago", "ana", "joão"]

  # Convert all names to uppercase
  names_upper = [for name in local.names : upper(name)]

  # Filter names starting with "j"
  names_starting_with_j = [for name in local.names : name if startswith(name, "j")]

  # Add index to each name
  names_with_index = [
    for i, name in local.names :
    "${i} - ${name}"
  ]

  # List of maps
  people = [
    { name = "thiago", age = 30 },
    { name = "ana", age = 25 },
    { name = "joão", age = 40 }
  ]

  # Filter people older than 30
  people_older_than_30 = [
    for person in local.people : person
    if person.age > 30
  ]

  # Add 5 to each person's age
  people_plus_5_years = [
    for person in local.people : {
      name  = person.name
      age   = person.age + 5
    }
  ]

  # Concatenate two lists
  extra_names = ["maria", "pedro"]
  all_names = concat(local.names, local.extra_names)

  # Sort list alphabetically
  sorted_names = sort(local.all_names)

  # Remove duplicates
  duplicates = ["a", "b", "a", "c", "b"]
  unique_values = distinct(local.duplicates)
}

output "names_upper" {
  value = local.names_upper
}

output "names_starting_with_j" {
  value = local.names_starting_with_j
}

output "names_with_index" {
  value = local.names_with_index
}

output "people_older_than_30" {
  value = local.people_older_than_30
}

output "people_plus_5_years" {
  value = local.people_plus_5_years
}

output "sorted_names" {
  value = local.sorted_names
}

output "unique_values" {
  value = local.unique_values
}
