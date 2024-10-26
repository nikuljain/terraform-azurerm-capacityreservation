variable capacity_reservation_group_name {
    type = string
    nullable = false
}

variable "resource_group_name" {
    type = string
    nullable = false  
}

variable "location" {
    type = string
    nullable = false
}
variable "capacity_reservations" {
  description = "Map of capacity reservations with SKU names and capacities."
  type = map(object({
    sku_name = string
    capacity = number
    zone     = string
  }))
}

variable "capacity_reservation_group_zones" {
  type = list(string)
  nullable = false
  default = [1,2,3]
}
