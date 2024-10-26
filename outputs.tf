output "capacity_reservation_group_id" {
  description = "The ID of the capacity reservation group."
  value       = azurerm_capacity_reservation_group.caprg.id
}

output "capacity_reservation_ids" {
  description = "The IDs of the capacity reservations."
  value       = { for k, v in azurerm_capacity_reservation.capacity_reservation : k => v.id }
}

output "capacity_reservation_names" {
  description = "The names of the capacity reservations."
  value       = { for k, v in azurerm_capacity_reservation.capacity_reservation : k => v.name }
}

output "capacity_reservation_skus" {
  description = "The SKUs of the capacity reservations."
  value       = { for k, v in azurerm_capacity_reservation.capacity_reservation : k => v.sku[0].name }
}

output "capacity_reservation_capacities" {
  description = "The capacities of the capacity reservations."
  value       = { for k, v in azurerm_capacity_reservation.capacity_reservation : k => v.sku[0].capacity }
}

output "capacity_reservation_zones" {
  description = "The zones of the capacity reservations."
  value       = { for k, v in azurerm_capacity_reservation.capacity_reservation : k => v.zone }
}
