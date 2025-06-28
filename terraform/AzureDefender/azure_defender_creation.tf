#Provider - Microsoft Azure
#Terraform Template to create Azure Defender pricing
#Organization - HCL Technologies
#File Name - azure_defender_creation.tf
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

#only supported for Single subscription and 1 exection
resource "azurerm_security_center_subscription_pricing" "AzureDefender" {
    count = length(var.ResourceType)
  tier          = var.Tier[count.index]
  resource_type = var.ResourceType[count.index]
}

#END OF FILE