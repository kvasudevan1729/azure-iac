variable "registry_name" {
  type = string
}

data "azurerm_resource_group" "lab_rg" {
  name = "<your resource group>"
}

resource "azurerm_container_registry" "registry" {
  name                = var.registry_name
  resource_group_name = data.azurerm_resource_group.lab_rg.name
  location            = data.azurerm_resource_group.lab_rg.location
  sku                 = "Standard"
  admin_enabled       = false

  tags = {
    Environment = "lab env"
  }
}

resource "azurerm_container_registry_scope_map" "registry_scope" {
  name                    = "${var.registry_name}-acr-scope-map"
  container_registry_name = azurerm_container_registry.registry.name
  resource_group_name     = data.azurerm_resource_group.lab_rg.name
  actions = [
    "repositories/lab_repo/content/read",
    "repositories/lab_repo/content/write"
  ]
}

resource "azurerm_container_registry_token" "registry_read_write_token" {
  name                    = "${var.registry_name}-read-write-token"
  container_registry_name = azurerm_container_registry.registry.name
  resource_group_name     = data.azurerm_resource_group.lab_rg.name
  scope_map_id            = azurerm_container_registry_scope_map.registry_scope.id
}

resource "azurerm_container_registry_token_password" "registry_read_write_token_pass" {
  container_registry_token_id = azurerm_container_registry_token.registry_read_write_token.id

  password1 {
    expiry = "2025-12-30T10:02:17.822+00:00"
  }

  password2 {
    expiry = "2025-06-01T10:02:17.822+00:00"
  }
}

output "registry_acr_login_server" {
  value = azurerm_container_registry.registry.login_server
}

output "cellfactory_acr_token_id" {
  value = azurerm_container_registry_token.registry_read_write_token.id
}

output "registry_acr_id" {
  value = azurerm_container_registry.registry.id
}
