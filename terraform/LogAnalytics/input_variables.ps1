<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	11 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	log_analytics_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create log analytics input variable file.

    .INPUTS
        This script required excel file which contain LogAnalytics worksheet details.
        
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
[string]$excel_worksheet_name = "LogAnalytics"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "LogAnalytics" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'Log Analytics Name'))`
      -or ([string]::IsNullOrEmpty($data.Sku)))

    {
        break
    }

    $location                 += '"' + ($data.location) + '"' + ','
    $existing_resource_group  += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $log_analytics_name       += '"' + (($data.'Log Analytics Name').Trim()) + '"' + ','
    $sku                      += '"' + (($data.Sku).Trim()) + '"' + ','
}

if (($location -eq $null) -or ($existing_resource_group -eq $null)`
     -or ($log_analytics_name -eq $null) -or ($sku -eq $null))
       
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $location                  = $location.TrimEnd(',')
    $existing_resource_group   = $existing_resource_group.TrimEnd(',')
    $log_analytics_name        = $log_analytics_name.TrimEnd(',')
    $sku                       = $sku.TrimEnd(',')

$variable_creation = @"
LogAnalyticsName         = [$log_analytics_name]
ExistingResourceGroup    = [$existing_resource_group]
Location                 = [$location]
Sku                      = [$sku]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################