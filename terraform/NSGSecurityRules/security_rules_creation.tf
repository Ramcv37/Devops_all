#Provider - Microsoft Azure
#Terraform Template to create multiple Security Rules based on Security rules name count
#Organization - HCL Technologies
#File Name - security_rules_creation.tf
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

resource "azurerm_network_security_rule" "securityrule" {
    count = length(var.SecurityRuleName)

    name                        = var.SecurityRuleName[count.index]
    priority                    = var.Priority[count.index]
    direction                   = var.Direction[count.index]
    access                      = var.Access[count.index]
    protocol                    = var.Protocol[count.index]
    source_port_range           = var.SourcePortRange[count.index]
    destination_port_range      = var.DestinationPortRange[count.index]
    source_address_prefix       = var.SourceAddressPrefix[count.index]
    destination_address_prefix  = var.DestinationAddressPrefix[count.index]
    resource_group_name         = var.NSGResourceGroupName[count.index]
    network_security_group_name = var.NSGName[count.index]
}

#END OF FILE