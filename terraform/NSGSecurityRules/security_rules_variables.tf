#Provider - Microsoft Azure
#This file contain Network Security Rules variables in List format
#Organization - HCL Technologies
#File Name - security_rules_variables.tf
#File version - 1.0

variable "NSGName" {
    type = list(string)
    description = "Network Security Group Name"
}

variable "NSGResourceGroupName" {
    type = list(string)
    description = "Network Security Group Resource Group Name"
}

variable "SecurityRuleName" {
    type = list(string)
    description = "NSG Security Rule Name"
}

variable "Priority" {
    type = list(string)
    description = "Security Rule Priority"
}

variable "Direction" {
    type = list(string)
    description = "Security Rule Direction"
}

variable "Access" {
    type = list(string)
    description = "Security Rule Access"
}

variable "Protocol" {
    type = list(string)
    description = "Security Rule Protocol"
}

variable "SourcePortRange" {
    type = list(string)
    description = "Source port range for security rule"
}

variable "DestinationPortRange" {
    type = list(string)
    description = "Destination port range for security rule"
}

variable "SourceAddressPrefix" {
    type = list(string)
    description = "Source Address prefix for security rule"
}

variable "DestinationAddressPrefix" {
    type = list(string)
    description = "Destination address prefix for security rule"
}
#END OF FILE