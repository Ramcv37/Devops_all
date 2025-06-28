#Provider - Microsoft Azure
#Terraform Template to create Azure Firewall
#Organization - HCL Technologies
#File Name - firewall_creation.tf
#File version - 1.0

#Terraform
terraform {
    required_version = "0.14.11"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "2.40.0"
        }
    }
  backend "azurerm" {
    }
}

#Azure provider
provider "azurerm" {
    features {}
}

data "azurerm_subnet" "subnet" {
    count = length(var.VirtualNetworkName)
  name                 = "AzureFirewallSubnet"
  virtual_network_name = var.VirtualNetworkName[count.index]
  resource_group_name  = var.VirtualNetworkResourceGroup[count.index]
}

resource "azurerm_public_ip" "publicIP" {
    count = length(var.PublicIPName)
  name                = var.PublicIPName[count.index]
  location            = var.PublicIPLocation[count.index]
  resource_group_name = var.PublicIPResourceGroup[count.index]
  allocation_method   = var.AllocationMethod[count.index]
  sku                 = var.SKU[count.index]
}

resource "azurerm_firewall" "firewall" {
    count = length(var.FirewallName)
  name                = var.FirewallName[count.index]
  location            = var.FirewallLocation[count.index]
  resource_group_name = var.FirewallResourceGroup[count.index]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[count.index].id
    public_ip_address_id = azurerm_public_ip.publicIP[count.index].id
  }
}

#END OF FILE