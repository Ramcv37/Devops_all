#Provider - Microsoft Azure
#Terraform Template to create multiple Recovery Vaults
#Organization - HCL Technologies
#File Name - recovery_vaults_creation.tf
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

resource "azurerm_recovery_services_vault" "vault" {
    count = length(var.VaultName)
  name                = var.VaultName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroupName[count.index]
  sku                 = var.SKU[count.index]
}

#END OF FILE