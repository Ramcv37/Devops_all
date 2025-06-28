#Provider - Microsoft Azure
#Terraform Template to create multiple Key Vaults
#Organization - HCL Technologies
#File Name - key_vault_creation.tf
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
    features {
        key_vault {
      purge_soft_delete_on_destroy = true
    }
    }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyVault" {
    count = length(var.KeyVaultName)
  name                        = var.KeyVaultName[count.index]
  location                    = var.Location[count.index]
  resource_group_name         = var.ResourceGroupName[count.index]
  enabled_for_disk_encryption = var.DiskEncryption[count.index]
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.SoftDeleteRetentionDays[count.index]
  purge_protection_enabled    = var.PurgeProtectionEnable[count.index]

  sku_name = var.SKUName[count.index]

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

  }
}

#END OF FILE