terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "<your resource group>"
    storage_account_name = "<storage account>"
    container_name       = "<container>"
    key                  = "lab-key-vault.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id                 = "<subscription id>"
  resource_provider_registrations = "none"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
