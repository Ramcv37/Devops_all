#Provider - Microsoft Azure
#This file contain NSG-Subnet-Association variables in List format
#Organization - HCL Technologies
#File Name - NSG-Subnet-Association_variables.tf
#File version - 1.0

variable "subnetID" {
    type = list(string)
    description = "Azure Subnet Resource ID"
}

variable "NSGID" {
    type = list(string)
    description = "Azure NSG ID"
}

#END OF SCRIPT