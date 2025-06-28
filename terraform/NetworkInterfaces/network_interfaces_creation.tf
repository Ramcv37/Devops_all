#Provider - Microsoft Azure
#Terraform Template to create multiple Network Interfaces
#Organization - HCL Technologies
#File Name - network_interfaces_creation.tf
#File version - 1.0

#Terraform
terraform {
    // required_version = "~> 3.0"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "3.0.0"
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
    count = length(var.SubnetName)
  name                 = var.SubnetName[count.index]
  virtual_network_name = var.VirtualNetworkName[count.index]
  resource_group_name  = var.VNETResourceGroup[count.index]
}

module "data" {
  source              = "./module/"
  count               = length(var.PublicIPName)
  name                = var.PublicIPName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroup[count.index]
  allocation_method   = var.AllocationMethod[count.index]
  sku                 = var.sku[count.index]
}

resource "azurerm_network_interface" "networkInterface" {
    count = length(var.NetworkInterfaceName)
  name                = var.NetworkInterfaceName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroup[count.index]

  ip_configuration {
    name                          = var.IPConfigurationName[count.index]
    subnet_id                     = data.azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = var.PrivateIPAllocation[count.index]
    public_ip_address_id          = var.PublicIPName[count.index] == "No" ? null : module.data[count.index].ip_address
  }
}

#END OF FILE