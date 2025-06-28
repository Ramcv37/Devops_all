<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	02 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	add_routes_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to add routes input variable file.

    .INPUTS
        This script required excel file which contain AddRoutes worksheet details.
        
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
[string]$excel_worksheet_name = "AddRoutes"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AddRoutes" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Route Table Name'))`
     -or ([string]::IsNullOrEmpty($data.'Route Table Resource Group'))`
      -or ([string]::IsNullOrEmpty($data.'Route Name'))`
       -or ([string]::IsNullOrEmpty($data.'Address Prefix'))`
        -or ([string]::IsNullOrEmpty($data.'Existing Firewall Name'))`
         -or ([string]::IsNullOrEmpty($data.'Existing Firewall Resource Group')))
    {
        break
    }

    $route_table_name                += '"' + (($data.'Route Table Name').Trim()) + '"' + ','
    $route_table_resourceGroup       += '"' + (($data.'Route Table Resource Group').Trim()) + '"' + ','
    $route_name                      += '"' + (($data.'Route Name').Trim()) + '"' + ','
    $address_prefix                  += '"' + (($data.'Address Prefix').Trim()) + '"' + ','
    $existing_firewall_name          += '"' + (($data.'Existing Firewall Name').Trim()) + '"' + ','
    $existing_firewall_resourceGroup += '"' + (($data.'Existing Firewall Resource Group').Trim()) + '"' + ','
}

if (($route_table_name  -eq $null) -or ($route_table_resourceGroup -eq $null) -or ($route_name -eq $null) -or ($address_prefix -eq $null) -or ($existing_firewall_name -eq $null) -or ($existing_firewall_resourceGroup -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

  $route_table_name                 = $route_table_name.TrimEnd(',')
  $route_table_resourceGroup        = $route_table_resourceGroup.TrimEnd(',')
  $route_name                       = $route_name.TrimEnd(',')
  $address_prefix                   = $address_prefix.TrimEnd(',')
  $existing_firewall_name           = $existing_firewall_name.TrimEnd(',')
  $existing_firewall_resourceGroup  = $existing_firewall_resourceGroup.TrimEnd(',')


$variable_creation = @"
RouteName                 = [$route_name]
RouteTableName            = [$route_table_name]
RouteTableResourceGroup   = [$route_table_resourceGroup]
AddressPrefix             = [$address_prefix]
FirewallName              = [$existing_firewall_name]
FirewallResourceGroup     = [$existing_firewall_resourceGroup]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################