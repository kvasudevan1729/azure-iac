data "azurerm_resource_group" "lab_rg" {
  name = "<your resource group>"
}

data "azurerm_virtual_network" "lab_vnet" {
  name                = "lab-vnet"
  resource_group_name = data.azurerm_resource_group.lab_rg.name
}

data "azurerm_subnet" "lab_vnet_subnet" {
  name                 = "default"
  resource_group_name  = data.azurerm_resource_group.lab_rg.name
  virtual_network_name = data.azurerm_virtual_network.lab_vnet.name
}
