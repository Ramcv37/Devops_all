<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	01 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	route_table_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create route table input variable file.

    .INPUTS
        This script required excel file which contain RouteTable worksheet details.
        
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
[string]$excel_worksheet_name = "RouteTable"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "RouteTable" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Route Table Name'))`
     -or ([string]::IsNullOrEmpty($data.'Existing Resource Group')))

    {
        break
    }
    $temp_location     = ((Get-AzResourceGroup -Name ($data.'Existing Resource Group')).Location)

    $rgname            += '"' + (($data.'Existing Resource Group').Trim()) + '"' + ','
    $route_table_name  += '"' + (($data.'Route Table Name').Trim()) + '"' + ','
    $location          += '"' + ($temp_location) + '"' + ','
}

if (($rgname -eq $null) -or ($route_table_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

  $rgname             = $rgname.TrimEnd(',')
  $route_table_name   = $route_table_name.TrimEnd(',')
  $location           = $location.TrimEnd(',')

$variable_creation = @"
RouteTableName           = [$route_table_name]
ResourceGroup            = [$rgname]
Location                 = [$location]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################