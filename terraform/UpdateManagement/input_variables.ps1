<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	15 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	update_management_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create update_management_input_variables file.

    .INPUTS
        This script required excel file which contain UpdateManagement worksheet details.
        
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
Import-Module ImportExcel
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "UpdateManagement"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "UpdateManagement" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Log Analytics Resource Group')) -or ([string]::IsNullOrEmpty($data.'Existing Log Analytics Name')) -or ([string]::IsNullOrEmpty($data.'Existing Automation Account Resource Group')) -or ([string]::IsNullOrEmpty($data.'Existing Automation Account Name')))
    {
        break
    }
    
    $log_analytics_name       += '"' + (($data.'Existing Log Analytics Name').Trim()) + '"' + ','
    $log_analytics_rg         += '"' + (($data.'Existing Log Analytics Resource Group').Trim()) + '"' + ','
    $automation_account       += '"' + (($data.'Existing Automation Account Name').Trim()) + '"' + ','
    $automation_account_rg    += '"' + (($data.'Existing Automation Account Resource Group').Trim()) + '"' + ','
}

if (($log_analytics_name  -eq $null) -or ($log_analytics_rg -eq $null) -or ($automation_account -eq $null) -or ($automation_account_rg -eq $null))
{
    Write-Error "some parameters have empty values please check and run again"
    exit
} 

$log_analytics_name     = $log_analytics_name.TrimEnd(',')
$log_analytics_rg       = $log_analytics_rg.TrimEnd(',')
$automation_account     = $automation_account.TrimEnd(',')
$automation_account_rg  = $automation_account_rg.TrimEnd(',')

$variable_creation = @"
LogAnalyticsName      = [$log_analytics_name]
LogAnalyticsRG        = [$log_analytics_rg]
AutomationAccountName = [$automation_account]
AutomationAccountRG   = [$automation_account_rg]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################