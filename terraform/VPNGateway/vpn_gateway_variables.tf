#Provider - Microsoft Azure
#This file contain vpn gateway variables (site-to-site) in List format
#Organization - HCL Technologies
#File Name - vpn_gateway_variables.tf
#File version - 1.0

variable "ResourceGroupName" {
    type = list(string)
    description = "Virtual Network Resource Group Name"
}

variable "Location" {
    type = list(string)
    description = "Resource Group Location"
}

variable "VirtualNetworkName" {
    type = list(string)
    description = "Virtual Network Name"
}

variable "SubnetName" {
    type = list(string)
    description = "Virtual Network Subnet Name"
}

#variable "SubnetAddressSpace" {
#    type = list(string)
#    description = "Virtual Network Subnet Address Space"
#}

variable "PublicIPName" {
    type = list(string)
    description = "Public IP Address Name"
}

variable "AllocationMethod" {
    type = list(string)
    description = "Public IP Address allocation method"
}

variable "VNETGatewayName" {
    type = list(string)
    description = "Virtual Network Gateway Name"
}

variable "GatewayType" {
    type = list(string)
    description = "VNET Gateway Type"
}

variable "VPNType" {
    type = list(string)
    description = "VPN Type"
}

variable "sku" {
    type = list(string)
    description = "VPN Gateway SKU"
}

#END OF FILE