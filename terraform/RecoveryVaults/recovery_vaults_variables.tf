#Provider - Microsoft Azure
#This file contain Recovery Vaults variables in List format
#Organization - HCL Technologies
#File Name - recovery_vaults_variables.tf
#File version - 1.0

variable "VaultName" {
    type = list(string)
    description = "Name for Recovery Vault"
}

variable "Location" {
    type = list(string)
    description = "Location of Recovery Vault"
}

variable "ResourceGroupName" {
    type = list(string)
    description = "Existing Resource Group Name"
}

variable "SKU" {
    type = list(string)
    description = "Set the SKU for vault"
}

# END OF FILE