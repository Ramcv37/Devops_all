#Provider - Microsoft Azure
#Terraform Template to create multiple Network Security Group based on NSG name count
#Organization - HCL Technologies
#File Name - NSG_creation.tf
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

resource "azurerm_network_security_group" "nsg" {
    count = length(var.NSGName)
  name                = var.NSGName[count.index]
  location            = var.NSGLocation[count.index]
  resource_group_name = var.NSGResourceGroupName[count.index]
}

#END OF FILE