#Provider - Microsoft Azure
#This file contain Azure Resouce Group Locks variables in List format
#Organization - HCL Technologies
#File Name - resource_group_locks_variables.tf
#File version - 1.0

variable "ResourceGroupName" {
    type = list(string)
    description = "Name of existing Resource Group Name"
}

variable "LockName" {
    type = list(string)
    description = "Name of The Lock"
}

variable LockType {
  type        = list(string)
  description = "Possible values CanNotDelete and ReadOnly"
}

variable LockNotes {
  type        = list(string)
  description = "Specify some notes about locks. Maximum of 512 characters"
}

# END OF FILE