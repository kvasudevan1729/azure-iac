output "tld_dns_zone_id" {
  value = azurerm_dns_zone.tld_dns_zone.id
}

output "tld_dns_zone_nameservers" {
  value = azurerm_dns_zone.tld_dns_zone.name_servers
}

output "azure_dns_zone_id" {
  value = azurerm_dns_zone.azure_dns_zone.id
}

output "azure_dns_zone_nameservers" {
  value = azurerm_dns_zone.azure_dns_zone.name_servers
}
