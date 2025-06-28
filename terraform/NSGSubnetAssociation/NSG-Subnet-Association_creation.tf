#Provider - Microsoft Azure
#Terraform Template to create multiple NSG-Subnet-Association
#Organization - HCL Technologies
#File Name - NSG-Subnet-Association_creation.tf
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

resource "azurerm_subnet_network_security_group_association" "NSGSubnet" {
    count = length(var.subnetID)
  subnet_id                 = var.subnetID[count.index]
  network_security_group_id = var.NSGID[count.index]
}

#END OF FILE