#Provider - Microsoft Azure
#Terraform Template to create update management
#Organization - HCL Technologies
#File Name - update_management_creation.tf
#File version - 1.0

#Terraform
terraform {
    required_version = "1.0.0"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "2.63.0"
        }
    }
  backend "azurerm" {
 }
}

#Azure provider
provider "azurerm" {
    features {}
}

data "azurerm_automation_account" "automationAccount" {
    count = length(var.AutomationAccountName)
  name                = var.AutomationAccountName[count.index]
  resource_group_name = var.AutomationAccountRG[count.index]
}

data "azurerm_log_analytics_workspace" "logAnalytics" {
    count = length(var.LogAnalyticsName)
  name                = var.LogAnalyticsName[count.index]
  resource_group_name = var.LogAnalyticsRG[count.index]
}

resource "azurerm_log_analytics_linked_service" "example" {
    count = length(var.AutomationAccountRG)
  resource_group_name = var.AutomationAccountRG[count.index]
  workspace_id        = data.azurerm_log_analytics_workspace.logAnalytics[count.index].id
  read_access_id      = data.azurerm_automation_account.automationAccount[count.index].id
}

#END OF FILE