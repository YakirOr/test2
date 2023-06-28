output "resource_group_name" {
  value = azurerm_resource_group.rg_name.name
}


output "storage-account-name" {
  value = azurerm_storage_account.storage-account.name
}


output "vnet-name" {
  value = azurerm_virtual_network.vnetinf.name
}


output "subnet-name" {
  value = azurerm_subnet.subnet-1.name
}


output "dns-zone-name" {
  value = azurerm_private_dns_zone.dns-zone.name
}

output "dns-Network-Link-name" {
  value = azurerm_private_dns_zone_virtual_network_link.network_link.name
}

output "dns-record-name" {
  value = azurerm_private_dns_a_record.dns_a_rec.name
}


output "sa-Private-Endpint-name" {
  value = azurerm_private_endpoint.prv_sa_endpoint.name
}


output "Function-App-name" {
  value = azurerm_function_app.function_app.name
}

output "role-assignment-name" {
  value = azurerm_role_assignment.role.name
}

output "App-Service-Plan-name" {
  value = azurerm_app_service_plan.app_service_plan.name
}

output "fa-Private-Endpint-name-name" {
  value = azurerm_private_endpoint.prv_function_app
}

output "diagnostic-app-service-name" {
  value = azurerm_monitor_diagnostic_setting.diagnostic-app-service.name
}

output "storage_ip_address" {
  value = azurerm_private_endpoint.prv_sa_endpoint.private_service_connection.0.private_ip_address
}


