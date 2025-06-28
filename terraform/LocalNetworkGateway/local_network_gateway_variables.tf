#Provider - Microsoft Azure
#This file contain Local Network Gateway variables in List format
#Organization - HCL Technologies
#File Name - local_network_gateway_variables.tf
#File version - 1.0

variable "GatewayName" {
    type = list(string)
    description = "Local Network Gateway Name"
}

variable "ResourceGroupName" {
    type = list(string)
    description = "Local Network Gateway Resource Group Name"
}

variable "Location" {
    type = list(string)
    description = "Local Network Gateway location"
}

variable "GatewayAddress" {
    type = list(string)
    description = "Local Network Gateway Address"
}

variable "AddressSpace" {
    type = list(string)
    description = "Local Network gateway Address Space"
}

# END OF FILE