#Provider - Microsoft Azure
#This file contain key vault variables in List format
#Organization - HCL Technologies
#File Name - key_vault_variables.tf
#File version - 1.0

variable "KeyVaultName" {
    type = list(string)
    description = "Name of the Key Vault"
}

variable "Location" {
    type = list(string)
    description = "Location of Availability Sets"
}

variable "ResourceGroupName" {
    type = list(string)
    description = "Existing Name of the Resource Group"
}

variable "DiskEncryption" {
    type = list(string)
    description = "Enabled Disk Encryption - Supported Value - True/False"
}

variable "SoftDeleteRetentionDays" {
    type = list(string)
    description = "Soft Delete Retention Days"
}

variable "PurgeProtectionEnable" {
    type = list(string)
    description = "Enabled Purge Protection - Supported Value - True/False"
}

variable "SKUName" {
    type = list(string)
    description = "SKU Name"
}

# END OF FILE