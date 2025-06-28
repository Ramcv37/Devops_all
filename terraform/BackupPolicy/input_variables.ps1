<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	29 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	backup_policy_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create backup policy input variable file.

    .INPUTS
        This script required excel file which contain BackupPolicy worksheet details.
        
    .NOTES
        This script required module as mentioned below
        Import-Excel PowerShell Module (Latest)

    .LINK
        Below are the link to download Required PowerShell Module
        https://www.powershellgallery.com/packages/ImportExcel/7.1.1
#>

$ErrorActionPreference = 'Stop'

#region importing module
Install-Module Importexcel -force
Import-Module ImportExcel -verbose
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "BackupPolicy"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "BackupPolicy" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Recovery Vault Name'))`
     -or ([string]::IsNullOrEmpty($data.'Existing Recovery Vault Resource Group'))`
      -or ([string]::IsNullOrEmpty($data.'Policy Name'))`
       -or ([string]::IsNullOrEmpty($data.TimeZone))`
        -or ([string]::IsNullOrEmpty($data.'Backup Time'))`
         -or ([string]::IsNullOrEmpty($data.'Retention Daily Count'))`
          -or ([string]::IsNullOrEmpty($data.'Retention Weekly Count'))`
           -or ([string]::IsNullOrEmpty($data.'Retention Weekly Weekdays'))`
            -or ([string]::IsNullOrEmpty($data.'Retention Monthly Count'))`
             -or ([string]::IsNullOrEmpty($data.'Retention Monthly Weekdays'))`
              -or ([string]::IsNullOrEmpty($data.'Retention Monthly Weeks'))`
               -or ([string]::IsNullOrEmpty($data.'Retention Yearly Count'))`
                -or ([string]::IsNullOrEmpty($data.'Retention Yearly Weekdays'))`
                 -or ([string]::IsNullOrEmpty($data.'Retention Yearly Weeks'))`
                  -or ([string]::IsNullOrEmpty($data.'Retension Yearly Months')))

    {
        break
    }

    $recovery_vault_name             += '"' + (($data.'Existing Recovery Vault Name').Trim()) + '"' + ','
    $recovery_vault_resource_group   += '"' + (($data.'Existing Recovery Vault Resource Group').Trim()) + '"' + ','
    $policy_name                     += '"' + (($data.'Policy Name').Trim()) + '"' + ','
    $time_zone                       += '"' + ($data.TimeZone) + '"' + ','
    $backup_frequency                += '"' + ($data.'Backup Frequency') + '"' + ','
    $backup_time                     += '"' + ($data.'Backup Time') + '"' + ','
    $retention_daily_count           += '"' + ($data.'Retention Daily Count') + '"' + ','
    $retention_weekly_count          += '"' + ($data.'Retention Weekly Count') + '"' + ','
    $retention_weekly_weekdays       += '(' + (($data.'Retention Weekly Weekdays').Trim()) + ')' + ','
    $retention_monthly_count         += '"' + ($data.'Retention Monthly Count') + '"' + ','
    $retention_monthly_weekdays      += '(' + (($data.'Retention Monthly Weekdays').Trim()) + ')' + ','
    $retention_monthly_weeks         += '(' + (($data.'Retention Monthly Weeks').Trim()) + ')' + ','
    $retention_yearly_count          += '"' + ($data.'Retention Yearly Count') + '"' + ','
    $retention_yearly_weekdays       += '(' + (($data.'Retention Yearly Weekdays').Trim()) + ')' + ','
    $retention_yearly_weeks          += '(' + (($data.'Retention Yearly Weeks').Trim()) + ')' + ','
    $retention_yearly_months         += '(' + (($data.'Retension Yearly Months').Trim()) + ')' + ','
}

if (($recovery_vault_name -eq $null)`
  -or ($recovery_vault_resource_group -eq $null)`
   -or ($policy_name -eq $null)`
    -or ($time_zone -eq $null)`
     -or ($backup_frequency -eq $null)`
      -or ($backup_time -eq $null)`
       -or ($retention_daily_count -eq $null)`
        -or ($retention_weekly_count -eq $null)`
         -or ($retention_weekly_weekdays -eq $null)`
          -or ($retention_monthly_count -eq $null)`
           -or ($retention_monthly_weekdays -eq $null)`
            -or ($retention_monthly_weeks -eq $null)`
             -or ($retention_yearly_count -eq $null)`
              -or ($retention_yearly_weekdays -eq $null)`
               -or ($retention_yearly_weeks -eq $null)`
                -or ($retention_yearly_months -eq $null))

{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$recovery_vault_name            = $recovery_vault_name.TrimEnd(',')
$recovery_vault_resource_group  = $recovery_vault_resource_group.TrimEnd(',')
$policy_name                    = $policy_name.TrimEnd(',')
$time_zone                      = $time_zone.TrimEnd(',')
$backup_frequency               = $backup_frequency.TrimEnd(',')
$backup_time                    = $backup_time.TrimEnd(',')
$retention_daily_count          = $retention_daily_count.TrimEnd(',')
$retention_weekly_count         = $retention_weekly_count.TrimEnd(',')
$retention_weekly_weekdays      = $retention_weekly_weekdays.TrimEnd(',')
$retention_monthly_count        = $retention_monthly_count.TrimEnd(',')
$retention_monthly_weekdays     = $retention_monthly_weekdays.TrimEnd(',')
$retention_monthly_weeks        = $retention_monthly_weeks.TrimEnd(',')
$retention_yearly_count         = $retention_yearly_count.TrimEnd(',')
$retention_yearly_weekdays      = $retention_yearly_weekdays.TrimEnd(',')
$retention_yearly_weeks         = $retention_yearly_weeks.TrimEnd(',')
$retention_yearly_months        = $retention_yearly_months.TrimEnd(',')


$variable_creation = @"
BackupPolicyName              = [$policy_name]
RecoveryVaultResourceGroup    = [$recovery_vault_resource_group]
RecoveryVaultName             = [$recovery_vault_name]
Timezone                      = [$time_zone]
Backupfrequency               = [$backup_frequency]
BackupTime                    = [$backup_time]
RetentionDailyCount           = [$retention_daily_count]
RetentionWeeklyCount          = [$retention_weekly_count]
RetentionWeeklyWeekdays       = [$retention_weekly_weekdays]
RetentionMonthlyCount         = [$retention_monthly_count]
RetentionMonthlyWeekdays      = [$retention_monthly_weekdays]
RetentionMonthlyWeeks         = [$retention_monthly_weeks]
RetentionYearlyCount          = [$retention_yearly_count]
RetentionYearlyWeekdays       = [$retention_yearly_weekdays]
RetentionYearlyWeeks          = [$retention_yearly_weeks]
RetentionYearlyMonths         = [$retention_yearly_months]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################