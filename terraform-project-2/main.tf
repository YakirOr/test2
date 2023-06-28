resource "azurerm_resource_group" "rg_name" {
  name = var.resource_group_name
  location = var.resource_group_location
}

#create storage account
resource "azurerm_storage_account" "storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg_name.name
  location                 = azurerm_resource_group.rg_name.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#Create virtual network
resource "azurerm_virtual_network" "vnetinf" {
  name = var.virtual_network_name
  location = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name
  address_space = ["172.25.0.0/24"]
}

#create subnet
resource "azurerm_subnet" "subnet-1" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.rg_name.name
  virtual_network_name = azurerm_virtual_network.vnetinf.name
  address_prefixes = ["172.25.0.0/28"]
  enforce_private_link_endpoint_network_policies = true
  depends_on = [
    azurerm_virtual_network.vnetinf
  ]
}


# Create Private DNS Zone
resource "azurerm_private_dns_zone" "dns-zone" {
  name                = var.dns_zone_name
  resource_group_name = azurerm_resource_group.rg_name.name
}

# Create Private DNS Zone Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = var.dns_network_link_name
  resource_group_name   = azurerm_resource_group.rg_name.name
  private_dns_zone_name = azurerm_private_dns_zone.dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnetinf.id
}

# Create DNS A Record
resource "azurerm_private_dns_a_record" "dns_a_rec" {
  name                = var.dns_record_name
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  resource_group_name = azurerm_resource_group.rg_name.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.prv_sa_endpoint.private_service_connection.0.private_ip_address]
}


# Create Private Endpoint for storage account
resource "azurerm_private_endpoint" "prv_sa_endpoint" {
  name                = var.private_endpoint_sa_name
  resource_group_name = azurerm_resource_group.rg_name.name
  location            = azurerm_resource_group.rg_name.location
  subnet_id           = azurerm_subnet.subnet-1.id
  private_service_connection {
    name                           = "storage_psc"
    private_connection_resource_id = azurerm_storage_account.storage-account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

# Create the Function App
resource "azurerm_function_app" "function_app" {
  name                       = var.function_app_name
  resource_group_name        = azurerm_resource_group.rg_name.name
  location                   = azurerm_resource_group.rg_name.location
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan.id
  storage_account_name       = azurerm_storage_account.storage-account.name
  storage_account_access_key = azurerm_storage_account.storage-account.primary_access_key

  identity {
    type = "SystemAssigned"

  }
}


#role assignment- allow function-app access to storage account
resource "azurerm_role_assignment" "role" {
  scope                = azurerm_storage_account.storage-account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.function_app.identity[0].principal_id
}


# Create the App Service Plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}


# Create Private Endpoint for function app
resource "azurerm_private_endpoint" "prv_function_app" {
  name                = var.Private_Endpoint_name_funapp_name
  resource_group_name = azurerm_resource_group.rg_name.name
  location            = azurerm_resource_group.rg_name.location
  subnet_id           = azurerm_subnet.subnet-1.id
  private_service_connection {
    name                           = "functionapp"
    private_connection_resource_id = azurerm_function_app.function_app.id
    is_manual_connection           = false
    subresource_names               = ["sites"]
  }
}



#service diagnostics for app service
resource "azurerm_monitor_diagnostic_setting" "diagnostic-app-service" {
  name               = var.as_service_diagnostics_name
  target_resource_id = azurerm_app_service_plan.app_service_plan.id
  storage_account_id = azurerm_storage_account.storage-account.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 3
    }
  }
}

