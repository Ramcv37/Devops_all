#Provider - Microsoft Azure
#Terraform Template to create Azure Automation Account
#Organization - HCL Technologies
#File Name - automation_account_creation.tf
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

resource "azurerm_automation_account" "automationAccount" {
    count = length(var.AutomationAccountName)
  name                = var.AutomationAccountName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroup[count.index]

  sku_name = var.sku[count.index]
}

#END OF FILE