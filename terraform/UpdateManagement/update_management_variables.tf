#Provider - Microsoft Azure
#This file contain update management link variables in List format
#Organization - HCL Technologies
#File Name - update_management_variables.tf
#File version - 1.0

variable "LogAnalyticsName" {
    type = list(string)
    description = "Name of Log Analytics Workspace"
}

variable "LogAnalyticsRG" {
    type = list(string)
    description = "Name of Log Analytics Workspace Resource Group"
}

variable "AutomationAccountName" {
    type = list(string)
    description = "Automation Account Name"
}

variable "AutomationAccountRG" {
    type = list(string)
    description = "Automation Account Resource Group"
}

#END OF SCRIPT