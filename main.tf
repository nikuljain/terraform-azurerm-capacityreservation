# Define a capacity reservation group in Azure
resource "azurerm_capacity_reservation_group" "caprg" {
  name                = var.capacity_reservation_group_name  # Name of the capacity reservation group
  resource_group_name = var.resource_group_name              # Resource group where the capacity reservation group will be created
  location            = var.location                          # Azure region for the capacity reservation group
  zones               = var.capacity_reservation_group_zones  # Availability zones for the capacity reservation group
}

# Define individual capacity reservations within the group
resource "azurerm_capacity_reservation" "capacity_reservation" {
  for_each = var.capacity_reservations  # Iterate over each capacity reservation defined in the variable

  name                          = each.key  # Name of the capacity reservation
  capacity_reservation_group_id = azurerm_capacity_reservation_group.caprg.id  # ID of the capacity reservation group
  sku {
    name     = each.value.sku_name  # SKU name for the capacity reservation
    capacity = each.value.capacity  # Capacity for the reservation
  }
  zone = each.value.zone  # Availability zone for the capacity reservation
}

# Define a custom role for deploying to capacity reservation groups
resource "azurerm_role_definition" "custom_role" {
  name        = "Custom Capacity Reservation Deployer"  # Name of the custom role
  scope       = azurerm_capacity_reservation_group.caprg.id  # Scope of the custom role
  description = "Custom role to deploy to capacity reservation groups"  # Description of the custom role

  permissions {
    actions = [
      "Microsoft.Compute/capacityReservationGroups/deploy/action"  # Permissions granted by the custom role
    ]
    not_actions = []  # Actions not allowed by the custom role
  }

  assignable_scopes = [
    azurerm_capacity_reservation_group.caprg.id  # Scopes where the custom role can be assigned
  ]
}

# Assign the custom role to a specific principal (user, group, or service principal)
resource "azurerm_role_assignment" "capacity_reservation_deploy" {
  principal_id         = "xxxx"  # The object ID of the AzureContainerService in your tenant 
  role_definition_name = azurerm_role_definition.custom_role.name  # Name of the custom role to assign
  scope                = azurerm_capacity_reservation_group.caprg.id  # Scope of the role assignment
}
