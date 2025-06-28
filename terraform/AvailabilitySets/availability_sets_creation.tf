#Provider - Microsoft Azure
#Terraform Template to create multiple Availability Sets
#Organization - HCL Technologies
#File Name - availability_sets_creation.tf
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

resource "azurerm_availability_set" "avset" {
    count = length(var.AVSETName)
  name                = var.AVSETName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroupName[count.index]

  platform_fault_domain_count = var.FaultDomain[count.index]
  platform_update_domain_count = var.UpdateDomain[count.index]

  managed = lower(var.Managed[count.index])
}

#END OF FILE