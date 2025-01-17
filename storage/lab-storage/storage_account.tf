# Create an Azure Storage Account

resource "azurerm_storage_account" "lab_tfstate" {
  name                             = "labtfstate"
  resource_group_name              = data.azurerm_resource_group.lab_rg.name
  location                         = data.azurerm_resource_group.lab_rg.location
  account_tier                     = "Standard"
  account_replication_type         = "RAGRS"
  cross_tenant_replication_enabled = false
  allow_nested_items_to_be_public  = false

  tags = {
    environment = "lab env"
  }
}

resource "azurerm_storage_account_network_rules" "lab_tfstate_net_rules" {
  storage_account_id = azurerm_storage_account.lab_tfstate.id

  default_action             = "Deny"
  ip_rules                   = [var.lab_gateway_ip_cidr]
  virtual_network_subnet_ids = [data.azurerm_subnet.lab_vnet_subnet.id]
  bypass                     = ["AzureServices"]
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "terraform-tfstate-files"
  storage_account_name  = azurerm_storage_account.lab_tfstate.name
  container_access_type = "private"
}
