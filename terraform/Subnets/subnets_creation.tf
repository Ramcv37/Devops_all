#Provider - Microsoft Azure
#Terraform Template to create multiple subnets based on subnet name count
#Organization - HCL Technologies
#File Name - subnets_creation.tf
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

resource "azurerm_subnet" "subnet" {
    count = length(var.SubnetName)
  name                 = var.SubnetName[count.index]
  resource_group_name  = var.VirtualNetworkResourceGroup[count.index]
  virtual_network_name = var.VirtualNetworkName[count.index]
  address_prefixes     = [var.AddressSpace[count.index]]
  enforce_private_link_endpoint_network_policies  = var.enforce_pep[count.index]
  enforce_private_link_service_network_policies   = var.enforce_private_link_service[count.index]
}

#END OF FILE