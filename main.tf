resource "azurerm_resource_group" "rg" {
  tags = {
    environment = var.environment
  }
  name     = "${var.environment}-resources"
  location = var.allowed_locations[2]
}
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_storage_account" "sa" {
  name                     = "${var.environment}storage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "con" {
  name                  = "${var.environment}-container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
