#Provider - Microsoft Azure
#This file contain firewall variables in List format
#Organization - HCL Technologies
#File Name - firewall_variables.tf
#File version - 1.0

variable "VirtualNetworkName" {
    type = list(string)
    description = "Name of the Virtual Network"
}

variable "VirtualNetworkResourceGroup" {
    type = list(string)
    description = "Virtual Network Resource Group"
}

variable "PublicIPName" {
    type = list(string)
    description = "Public IP Address Name"
}

variable "PublicIPResourceGroup" {
    type = list(string)
    description = "Public IP Resource Group Name"
}

variable "PublicIPLocation" {
    type = list(string)
    description = "Location/region of Public IP Address"
}

variable "AllocationMethod" {
    type = list(string)
    description = "Public IP Address Allocation Method"
}

variable "SKU" {
    type = list(string)
    description = "Public IP SKU"
}

variable "FirewallName" {
    type = list(string)
    description = "Firewall Name"
}

variable "FirewallResourceGroup" {
    type = list(string)
    description = "Firewall Resource Group Name"
}

variable "FirewallLocation" {
    type = list(string)
    description = "Location/Region of Azure Firewall"
}
# END OF FILE