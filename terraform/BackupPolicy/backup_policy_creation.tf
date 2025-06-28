#Provider - Microsoft Azure
#Terraform Template to create Recovery Vault Backup Policy
#Organization - HCL Technologies
#File Name - backup_policy_creation.tf
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

resource "azurerm_backup_policy_vm" "backupPolicy" {
    count = length(var.BackupPolicyName)
  name                = var.BackupPolicyName[count.index]
  resource_group_name = var.RecoveryVaultResourceGroup[count.index]
  recovery_vault_name = var.RecoveryVaultName[count.index]

  timezone = var.Timezone[count.index]

  backup {
    frequency = var.Backupfrequency[count.index]
    time      = var.BackupTime[count.index]
  }

  retention_daily {
    count = var.RetentionDailyCount[count.index]
  }

  retention_weekly {
    count    = var.RetentionWeeklyCount[count.index]
    weekdays = [var.RetentionWeeklyWeekdays[count.index]]
  }

  retention_monthly {
    count    = var.RetentionMonthlyCount[count.index]
    weekdays = [var.RetentionMonthlyWeekdays[count.index]]
    weeks    = [var.RetentionMonthlyWeeks[count.index]]
  }

  retention_yearly {
    count    = var.RetentionYearlyCount[count.index]
    weekdays = [var.RetentionYearlyWeekdays[count.index]]
    weeks    = [var.RetentionYearlyWeeks[count.index]]
    months   = [var.RetentionYearlyMonths[count.index]]
  }
}

#END OF FILE