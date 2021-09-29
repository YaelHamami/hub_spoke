terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    azurem = {
      source  = "hashicorp/azurerm"
      version = ">= 2.72.0"
    }
  }
}

