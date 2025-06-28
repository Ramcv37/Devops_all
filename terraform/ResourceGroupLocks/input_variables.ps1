<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	17 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	resource_group_locks_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create Resource Group Locks input variable file.

    .INPUTS
        This script required excel file which contain ResourceGroupLocks worksheet details.
        
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
[string]$excel_worksheet_name = "ResourceGroupLocks"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "ResourceGroupLocks" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'Lock Name'))`
      -or ([string]::IsNullOrEmpty($data.'Lock Type'))`
       -or ([string]::IsNullOrEmpty($data.'Lock Notes')))

    {
        break
    }

    $resource_group   += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $lock_name        += '"' + (($data.'Lock Name').Trim()) + '"' + ','
    $lock_type        += '"' + (($data.'Lock Type').Trim()) + '"' + ','
    $lock_notes       += '"' + (($data.'Lock Notes').Trim()) + '"' + ','
}

if (($resource_group -eq $null) -or ($lock_name -eq $null)`
     -or ($lock_type -eq $null) -or ($lock_notes -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$resource_group  = $resource_group.TrimEnd(',')
$lock_name       = $lock_name.TrimEnd(',')
$lock_type       = $lock_type.TrimEnd(',')
$lock_notes      = $lock_notes.TrimEnd(',')

$variable_creation = @"
LockName             = [$lock_name]
ResourceGroupName    = [$resource_group]
LockType             = [$lock_type]
LockNotes            = [$lock_notes]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################