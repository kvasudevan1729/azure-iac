data "azurerm_resource_group" "lab_rg" {
  name = "<your resource group>"
}

resource "azurerm_dns_zone" "tld_dns_zone" {
  name                = var.tld_dns_zone_name
  resource_group_name = data.azurerm_resource_group.lab_rg.name

  tags = {
    Environment = "lab env"
  }
}

resource "azurerm_dns_zone" "azure_dns_zone" {
  name                = var.azure_dns_zone_name
  resource_group_name = data.azurerm_resource_group.lab_rg.name

  tags = {
    Environment = "lab env"
  }
}

# create 
resource "azurerm_dns_ns_record" "azure_ns" {
  name                = "az"
  zone_name           = azurerm_dns_zone.tld_dns_zone.name
  resource_group_name = data.azurerm_resource_group.lab_rg.name
  ttl                 = 28800

  records = azurerm_dns_zone.azure_dns_zone.name_servers

  tags = {
    Environment = "lab env"
  }
}
