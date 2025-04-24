provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  use_oidc = true
}

data "azurerm_client_config" "current" {}

locals {
  resource_group_name = "${var.company_trig}-${var.env}-RG-${var.service_name}"
}

#
#  https://github.com/Azure/terraform-azurerm-naming/tree/master
module "naming" {
  source = "Azure/naming/azurerm"

  prefix        = ["${var.company_trig}", "${var.env}"] #  Trig Compagny, Env
  suffix        = ["${var.service_name}"]               # Service_Name or Project
  unique-length = 4                                     # = default
}

resource "azurerm_resource_group" "rg" {
  name     = upper(module.naming.resource_group.name)
  location = var.location
  
  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = lower(module.naming.virtual_network.name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "vm_subnet_public" {
  address_prefixes     = var.address_snet_public
  name                 = lower("${module.naming.subnet.name}-Front")
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "vm_subnet_private" {
  address_prefixes     = var.address_snet_private
  name                 = lower("${module.naming.subnet.name}-Back")
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}