terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "<your resource group>"
    storage_account_name = "<storage account name>"
    container_name       = "<container name>"
    key                  = "dns-zones.tfstate"
  }
}

provider "azurerm" {
  subscription_id                 = "<subscription id>"
  resource_provider_registrations = "none"
  features {}
}
