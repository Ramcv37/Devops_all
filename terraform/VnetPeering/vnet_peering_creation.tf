#Provider - Microsoft Azure
#Terraform Template to create Vnet Peering
#Organization - HCL Technologies
#File Name - vnet_peering_creation.tf
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

resource "azurerm_virtual_network_peering" "VnetPeering" {
    count = length(var.PeeringName)
    name                      = var.PeeringName[count.index]
    resource_group_name       = var.LocalVnetResourceGroup[count.index]
    virtual_network_name      = var.LocalVNet[count.index]
    remote_virtual_network_id = var.RemoteVnetID[count.index]
}

#END OF FILE