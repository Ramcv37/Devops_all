<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	03 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	route_subnet_Association_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create Route-Subnet-Association_input_variables file.

    .INPUTS
        This script required excel file which contain Route-Subnet-Association worksheet details.
        
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
[string]$excel_worksheet_name = "Route-Subnet-Association"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "RouteSubnetAssociation" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Route Table Name')) -or ([string]::IsNullOrEmpty($data.'Existing Route Table Resource Group')) -or ([string]::IsNullOrEmpty($data.'Existing Subnet Name')) -or ([string]::IsNullOrEmpty($data.'Existing Virtual Network Name')) -or ([string]::IsNullOrEmpty($data.'Existing VNET Resource Group')))
    {
        break
    }
    
    $subnet_id         += '"' + (Get-AzVirtualNetwork -Name (($data.'Existing Virtual Network Name').Trim()) -ResourceGroupName (($data.'Existing VNET Resource Group').Trim()) | Get-AzVirtualNetworkSubnetConfig | Where-Object {$_.Name -eq (($data.'Existing Subnet Name').Trim())}).Id + '"' + ','
    $route_table_id    += '"' + (Get-AzRouteTable -Name (($data.'Existing Route Table Name').Trim()) -ResourceGroupName (($data.'Existing Route Table Resource Group').Trim())).Id + '"' + ','
}

if (($subnet_id -eq $null) -or ($route_table_id -eq $null))
{
    Write-Error "Route Table id or Subnet id have empty values please check and run again"
    exit
} 

$subnet_id         = $subnet_id.TrimEnd(',')
$route_table_id    = $route_table_id.TrimEnd(',')

$variable_creation = @"
SubnetId         = [$subnet_id]
RouteTableId     = [$route_table_id]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################