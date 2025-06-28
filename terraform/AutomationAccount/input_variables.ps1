<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	14 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	automation_account_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create automation account input variable file.

    .INPUTS
        This script required excel file which contain AutomationAccount worksheet details.
        
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
[string]$excel_worksheet_name = "AutomationAccount"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AutomationAccount" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'Automation Account Name'))`
      -or ([string]::IsNullOrEmpty($data.'SKU Name')))

    {
        break
    }

    $resource_group            += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $automation_account_name   += '"' + (($data.'Automation Account Name').Trim()) + '"' + ','
    $location                  += '"' + ((Get-AzResourceGroup -Name (($data.'Existing Resource Group Name').Trim()) | Select-Object Location).location)  + '"' + ','
    $sku_name                  += '"' + (($data.'SKU Name').Trim()) + '"' + ','
}

if (($resource_group -eq $null) -or ($automation_account_name -eq $null)`
     -or ($location -eq $null) -or ($sku_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$resource_group           = $resource_group.TrimEnd(',')
$automation_account_name  = $automation_account_name.TrimEnd(',')
$location                 = $location.TrimEnd(',')
$sku_name                 = $sku_name.TrimEnd(',')

$variable_creation = @"
AutomationAccountName    = [$automation_account_name]
ExistingResourceGroup    = [$resource_group]
Location                 = [$location]
sku                      = [$sku_name]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################