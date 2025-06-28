#Provider - Microsoft Azure
#Terraform Template to create Bastion Host
#Organization - HCL Technologies
#File Name - bastion_creation.tf
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
    count = length(var.Subnet)
  name                 = var.Subnet[count.index]
  virtual_network_name = var.VirtualNetworkName[count.index]
  resource_group_name  = var.VNETResourceGroup[count.index]
}

resource "azurerm_public_ip" "publicIP" {
    count = length(var.PublicIPName)
  name                = var.PublicIPName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroupName[count.index]
  allocation_method   = var.AllocationMethod[count.index]
  sku                 = var.sku[count.index]
}

resource "azurerm_bastion_host" "bastion" {
    count = length(var.BastionHostName)
  name                = var.BastionHostName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroupName[count.index]

  ip_configuration {
    name                 = var.IPConfigurationName[count.index]
    subnet_id            = data.azurerm_subnet.subnet[count.index].id
    public_ip_address_id = azurerm_public_ip.publicIP[count.index].id
  }
}

#END OF FILE