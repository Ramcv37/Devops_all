#Provider - Microsoft Azure
#This file contain Availability Sets variables in List format
#Organization - HCL Technologies
#File Name - availability_sets_variables.tf
#File version - 1.0

variable "ResourceGroupName" {
    type = list(string)
    description = "Existing Resource Group Name"
}

variable "AVSETName" {
    type = list(string)
    description = "Name of Availability Sets"
}

variable "Location" {
    type = list(string)
    description = "Location of Availability Sets"
}

variable "FaultDomain" {
    type = list(string)
    description = "Availability Set Fault Domain Count"
}

variable "UpdateDomain" {
    type = list(string)
    description = "Availability Set Update Domain Count"
}

variable "Managed" {
    type = list(string)
    description = "Use Managed Disks value (Only True and False supported)"
}

# END OF FILE