#Provider - Microsoft Azure
#This file contain Resource Group Name and location variables in List format
#Organization - HCL Technologies
#File Name - resource_group_variables.tf
#File version - 1.0

variable "ResourceGroupName" {
    type        = list(string)
    description = "Resource Group Name"
}

variable "ResourceGroupLocation" {
    type        = list(string)
    description = "Resource Group Location"
}

#End of File