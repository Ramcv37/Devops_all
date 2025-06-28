#Provider - Microsoft Azure
#This file contain Azure Defender variables in List format
#Organization - HCL Technologies
#File Name - azure_defender_variables.tf
#File version - 1.0

variable "Tier" {
    type = list(string)
    description = "azure defender pricing tier"
}

variable "ResourceType" {
    type = list(string)
    description = "Azure Defender Resource Type"
}

# END OF FILE