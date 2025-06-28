#Provider - Microsoft Azure
#Terraform Template to add Azure locks on Resource Groups
#Organization - HCL Technologies
#File Name - resource_group_locks_creation.tf
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

data "azurerm_resource_group" "resourceGroupName" {
    count = length(var.ResourceGroupName)
  name = var.ResourceGroupName[count.index]
}

resource "azurerm_management_lock" "resource-group-level" {
    count = length(var.ResourceGroupName)
  name       = var.LockName[count.index]
  scope      = data.azurerm_resource_group.resourceGroupName[count.index].id
  lock_level = var.LockType[count.index]
  notes      = var.LockNotes[count.index]
}


#END OF FILE