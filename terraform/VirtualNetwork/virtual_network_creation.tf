#Provider - Microsoft Azure
#Terraform Template to create multiple virtual networks based on virtual network name count
#Organization - HCL Technologies
#File Name - virtual_network_creation.tf
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

resource "azurerm_virtual_network" "vnet" {
    count = length(var.VirtualNetworkName)

  name                = var.VirtualNetworkName[count.index]
  location            = var.VirtualNetworkLocation[count.index]
  resource_group_name = var.VirtualNetworkResourceGroup[count.index]
  address_space       = [var.AddressSpace[count.index]]
}