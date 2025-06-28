#Provider - Microsoft Azure
#Terraform Template to create Local Network Gateway
#Organization - HCL Technologies
#File Name - local_network_gateway_creation.tf
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

resource "azurerm_local_network_gateway" "onpremise" {
    count = length(var.GatewayName)
  name                = var.GatewayName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroupName[count.index]
  gateway_address     = var.GatewayAddress[count.index]
  address_space       = [var.AddressSpace[count.index]]
}

#END OF FILE