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
  name                = "test-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_snet_public

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
    }
  }
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_snet_private
}

resource "azurerm_network_security_group" "public_nsg" {
  name                = "public-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "private_nsg" {
  name                = "private-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "public_nsg_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "private_nsg_assoc" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}