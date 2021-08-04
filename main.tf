provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

resource "azurerm_resource_group" "project" {
  name     = "project"
  location = "West Europe"
}