#Provider - Microsoft Azure
#This file contain Network Security Group variables in List format
#Organization - HCL Technologies
#File Name - NSG_variables.tf
#File version - 1.0

variable "NSGName" {
    type = list(string)
    description = "Network Security Group Name"
}

variable "NSGLocation" {
    type = list(string)
    description = "Network Security Group Location"
}

variable "NSGResourceGroupName" {
    type = list(string)
    description = "Network Security Group Resource Group Name"
}

#END OF FILE