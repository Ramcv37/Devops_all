<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	17 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	nsg_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create NSG input variable file.

    .INPUTS
        This script required excel file which contain NSG worksheet details.
        
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
[string]$excel_worksheet_name = "NSG"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "NSG" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'NSG Resource Group Name')) -or ([string]::IsNullOrEmpty($data.'NSG Name')) -or ([string]::IsNullOrEmpty($data.Location)))
    {
        break
    }
    $rgname     += '"' + (($data.'NSG Resource Group Name').Trim()) + '"' + ','
    $location   += '"' + (($data.Location).Trim()) + '"' + ','
    $NSGName    += '"' + (($data.'NSG Name').Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($location -eq $null) -or ($NSGName -eq $null))
{
    Write-Error "Resource Group or Location or NSG Name have empty values please check parameters and run again"
    exit
} 

$rgname    = $rgname.TrimEnd(',')
$location  = $location.TrimEnd(',')
$NSGName   = $NSGName.TrimEnd(',')

$variable_creation = @"
NSGName               = [$NSGName]
NSGLocation           = [$location]
NSGResourceGroupName  = [$rgname]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################