#Provider - Microsoft Azure
#This file contain Azure Automation Account variables in List format
#Organization - HCL Technologies
#File Name - automation_account_variables.tf
#File version - 1.0

variable "AutomationAccountName" {
    type = list(string)
    description = "Name of the Automation Account"
}

variable "ExistingResourceGroup" {
    type = list(string)
    description = "Name of existing Resource Group Name"
}

variable "Location" {
  type        = list(string)
  description = "Resource Group Location"
}

variable "sku" {
  type        = list(string)
  description = "SKU name, Only Basic supported"
}

# END OF FILE