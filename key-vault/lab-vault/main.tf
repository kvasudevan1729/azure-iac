# create a key vault for azure disk encryption and secrets

data "azurerm_resource_group" "lab_rg" {
  name = "<resource group>"
}

data "azurerm_client_config" "current" {}

data "azuread_users" "key_vault_users" {
  user_principal_names = var.key_vault_users
}

resource "azurerm_key_vault" "lab_vault" {
  name                        = "lab-vault-ty8976pm"
  resource_group_name         = data.azurerm_resource_group.lab_rg.name
  location                    = data.azurerm_resource_group.lab_rg.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [var.lab_wan_ip_cidr]
  }

  tags = {
    environment = "lab env"
  }
}

resource "azurerm_key_vault_access_policy" "vm_key_access_policy" {
  count        = length(var.key_vault_users)
  key_vault_id = azurerm_key_vault.lab_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_users.key_vault_users.object_ids[count.index]

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Delete",
    "Recover",
    "Encrypt",
    "Decrypt",
    "WrapKey",
    "UnwrapKey",
    "Verify",
    "Sign",
    "Purge",
    "Release",
    "Rotate",
    "GetRotationPolicy",
    "SetRotationPolicy",
  ]
}

output "lab_vault_id" {
  value = resource.azurerm_key_vault.lab_vault.id
}

output "lab_vault_uri" {
  value = resource.azurerm_key_vault.lab_vault.vault_uri
}
