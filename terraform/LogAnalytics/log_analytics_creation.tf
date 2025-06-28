#Provider - Microsoft Azure
#Terraform Template to create multiple Log analytics workspace
#Organization - HCL Technologies
#File Name - log_analytics_creation.tf
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

resource "azurerm_log_analytics_workspace" "logAnalytics" {
    count = length(var.LogAnalyticsName)
  name                = var.LogAnalyticsName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ExistingResourceGroup[count.index]
  sku                 = var.Sku[count.index]
}

#End of File