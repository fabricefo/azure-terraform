output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "public_subnet_id" {
  value = azurerm_subnet.vm_subnet_public.id
}

output "private_subnet_id" {
  value = azurerm_subnet.vm_subnet_private.id
}