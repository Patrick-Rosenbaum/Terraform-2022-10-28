resource "azurerm_resource_group" "patrick-demo-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "patrick-demo-storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.patrick-demo-rg
  ]
}

resource "azurerm_storage_container" "patrick-demo-container" {
  name                  = var.storage_container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "blob"

  depends_on = [
    azurerm_storage_account.patrick-demo-storage
  ]
}

resource "azurerm_storage_blob" "patrick-demo-blob" {
  name                   = "my-epic-content"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  # source                 = "terraform.tfstate"

  depends_on = [
    azurerm_storage_container.patrick-demo-container
  ]
}