#Provider - Microsoft Azure
#Terraform Template to create multiple resource group based on Resource Group Name count
#Organization - HCL Technologies
#File Name - resource_group_creation.tf
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

#create resource group
resource "azurerm_resource_group" "rg" {
    count = length(var.ResourceGroupName)

    name     = var.ResourceGroupName[count.index]
    location = var.ResourceGroupLocation[count.index]
}

#End of File