<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	15 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	resource_groups_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create resource group input variable file.

    .INPUTS
        This script required excel file which contain resourceGroup worksheet and resource group name and location details.
        
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
[string]$excel_worksheet_name = "ResourceGroup"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "ResourceGroup" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Resource Group Name')) -or ([string]::IsNullOrEmpty($data.Location)))
    {
        break
    }
    $rgname   += '"' + (($data.'Resource Group Name').Trim()) + '"' + ','
    $location += '"' + (($data.Location).Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($location -eq $null))
{
    Write-Error "Resource Group or Location have empty values please check parameters and run again"
    exit
} 

$rgname = $rgname.TrimEnd(',')
$location = $location.TrimEnd(',')

$variable_creation = @"
ResourceGroupName = [$rgname]
ResourceGroupLocation = [$location]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################