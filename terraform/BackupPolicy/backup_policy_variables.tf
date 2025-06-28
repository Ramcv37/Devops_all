#Provider - Microsoft Azure
#This file contain Azure Recovery Vault Backup Policy variables in List format
#Organization - HCL Technologies
#File Name - backup_policy_variables.tf
#File version - 1.0

variable "BackupPolicyName" {
    type = list(string)
    description = "Name of the Backup Policy"
}

variable "RecoveryVaultResourceGroup" {
    type = list(string)
    description = "Existing Recovery Vault Resource Group Name"
}

variable "RecoveryVaultName" {
  type        = list(string)
  description = "Existing Recovery Vault Name"
}

variable "Timezone" {
  type        = list(string)
  description = "Timezone in UTC format"
}

variable "Backupfrequency" {
  type        = list(string)
  description = "Backup Frequency - Daily or Weekly value supported"
}

variable "BackupTime" {
  type        = list(string)
  description = "Backup Time in 24 Hours format supported"
}

variable "RetentionDailyCount" {
  type        = list(string)
  description = "The number of daily backups to keep. Must be between 7 and 9999."
}

variable "RetentionWeeklyCount" {
  type        = list(string)
  description = "The number of weekly backups to keep. Must be between 1 and 9999."
}

variable "RetentionWeeklyWeekdays" {
  type        = list(string)
  description = "The weekday backups to retain. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "RetentionMonthlyCount" {
  type        = list(string)
  description = "The number of monthly backups to keep. Must be between 1 and 9999"
}

variable "RetentionMonthlyWeekdays" {
  type        = list(string)
  description = "The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "RetentionMonthlyWeeks" {
  type        = list(string)
  description = "The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last."
}

variable "RetentionYearlyCount" {
  type        = list(string)
  description = "The number of yearly backups to keep. Must be between 1 and 9999"
}

variable "RetentionYearlyWeekdays" {
  type        = list(string)
  description = "The weekday backups to retain . Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday."
}

variable "RetentionYearlyWeeks" {
  type        = list(string)
  description = "The weeks of the month to retain backups of. Must be one of First, Second, Third, Fourth, Last."
}

variable "RetentionYearlyMonths" {
  type        = list(string)
  description = "The months of the year to retain backups of. Must be one of January, February, March, April, May, June, July, August, September, October, November and December."
}
# END OF FILE