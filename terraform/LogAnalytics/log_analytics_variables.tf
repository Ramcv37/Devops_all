#Provider - Microsoft Azure
#This file contain Log Analytics Variables in List format
#Organization - HCL Technologies
#File Name - log_analytics_variables.tf
#File version - 1.0

variable "LogAnalyticsName" {
    type        = list(string)
    description = "Log Analytics Name"
}

variable "ExistingResourceGroup" {
    type        = list(string)
    description = "Existing Resource Group Name"
}

variable "Location" {
    type = list(string)
    description = "Existing Resource Group Location"
}

variable "Sku" {
    type = list(string)
    description = "Sku details"
}

#End of File