output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "public_subnet_id" {
  value = azurerm_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "postgresql_server_name" {
  value = azurerm_postgresql_flexible_server.postgresql.name
}

output "container_app_url" {
  value = azurerm_container_group.container_app.ip_address[0].ip
}