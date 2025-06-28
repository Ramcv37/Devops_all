#Provider - Microsoft Azure
#Terraform Template to create multiple Connections for VPN Gateway and Local Network Gateway
#Organization - HCL Technologies
#File Name - connections_creation.tf
#File version - 1.0

#Terraform
#azure storage account backend provided to store terraform state file using release pipeline
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

resource "azurerm_virtual_network_gateway_connection" "onpremise" {
    count = length(var.ConnectionName)
  name                       = var.ConnectionName[count.index]
  location                   = var.ResourceGroupLocation[count.index]
  resource_group_name        = var.ResourceGroupName[count.index]

  type                       = "IPsec"
  virtual_network_gateway_id = var.VPNGatewayID[count.index]
  local_network_gateway_id   = var.LocalNetworkgatewayID[count.index]

  shared_key = var.SharedKey[count.index]
}

#End of File