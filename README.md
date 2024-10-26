# Terraform AzureRM Capacity Reservation Module

This module manages Azure Capacity Reservations and Capacity Reservation Groups using Terraform.

## Features

- Create and manage Azure Capacity Reservation Groups.
- Create and manage individual Capacity Reservations within a group.
- Define custom roles for deploying to Capacity Reservation Groups.
- Assign custom roles to specific principals.

## Usage

### Define Variables

Ensure you have the following variables defined in your Terraform configuration:

```hcl
variable "capacity_reservation_group_name" {
  description = "The name of the capacity reservation group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the capacity reservation group."
  type        = string
}

variable "capacity_reservation_group_zones" {
  description = "The availability zones for the capacity reservation group."
  type        = list(string)
}

variable "capacity_reservations" {
  description = "A map of capacity reservations."
  type        = map(object({
    sku_name = string
    capacity = number
    zone     = string
  }))
}

Example :

module "capacity_reservation" {
  source = "./terraform-azurerm-capacityreservation"

  capacity_reservation_group_name = var.capacity_reservation_group_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  capacity_reservation_group_zones = var.capacity_reservation_group_zones
  capacity_reservations           = var.capacity_reservations
}
```

### Outputs
The module provides the following outputs:

- capacity_reservation_group_id: The ID of the capacity reservation group.
- capacity_reservation_ids: The IDs of the capacity reservations.
- capacity_reservation_names: The names of the capacity reservations.
- capacity_reservation_skus: The SKUs of the capacity reservations.
- capacity_reservation_capacities: The capacities of the capacity reservations.
- capacity_reservation_zones: The zones of the capacity reservations.

### Resources

- azurerm_capacity_reservation_group.caprg: Defines a capacity reservation group.

- azurerm_capacity_reservation.capacity_reservation: Defines individual capacity reservations within the group.

- azurerm_role_definition.custom_role: Defines a custom role for deploying to capacity reservation groups.

- azurerm_role_assignment.capacity_reservation_deploy: Assigns the custom role to a specific principal.
