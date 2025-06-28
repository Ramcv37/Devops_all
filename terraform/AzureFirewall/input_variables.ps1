<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	28 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	firewall_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create firewall input variable file.

    .INPUTS
        This script required excel file which contain AzureFirewall worksheet details.
        
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
[string]$excel_worksheet_name = "AzureFirewall"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AzureFirewall" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'VNET Name'))`
     -or ([string]::IsNullOrEmpty($data.'VNET Resource Group'))`
      -or ([string]::IsNullOrEmpty($data.'Public IP Name'))`
       -or ([string]::IsNullOrEmpty($data.'Public IP Location'))`
        -or ([string]::IsNullOrEmpty($data.'Existing Resource Group for Public IP'))`
         -or ([string]::IsNullOrEmpty($data.'Allocation Method'))`
          -or ([string]::IsNullOrEmpty($data.SKU))`
           -or ([string]::IsNullOrEmpty($data.'Firewall Name'))`
            -or ([string]::IsNullOrEmpty($data.'Firewall Location')))

    {
        break
    }

    $VNET_name            += '"' + (($data.'VNET Name').Trim()) + '"' + ','
    $VNET_RG              += '"' + (($data.'VNET Resource Group').Trim()) + '"' + ','
    $PublicIP_Name        += '"' + (($data.'Public IP Name').Trim()) + '"' + ','
    $PublicIP_RG          += '"' + (($data.'Existing Resource Group for Public IP').Trim()) + '"' + ','
    $PublicIP_Location    += '"' + (($data.'Public IP Location').Trim()) + '"' + ','
    $allocation_method    += '"' + (($data.'Allocation Method').Trim()) + '"' + ','
    $sku                  += '"' + (($data.SKU).Trim()) + '"' + ','
    $firewall_name        += '"' + (($data.'Firewall Name').Trim()) + '"' + ','
    $firewall_RG          += '"' + (($data.'Existing Resource Group for Firewall').Trim()) + '"' + ','
    $firewall_location    += '"' + (($data.'Firewall Location').Trim()) + '"' + ','
}

if (($VNET_name -eq $null) -or ($VNET_RG -eq $null)`
     -or ($PublicIP_Name -eq $null) -or ($PublicIP_RG -eq $null)`
       -or ($PublicIP_Location -eq $null) -or ($allocation_method -eq $null) -or ($sku -eq $null) -or ($firewall_name -eq $null)`
         -or ($firewall_RG -eq $null) -or ($firewall_location -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $VNET_name          = $VNET_name.TrimEnd(',')
    $VNET_RG            = $VNET_RG.TrimEnd(',')
    $PublicIP_Name      = $PublicIP_Name.TrimEnd(',')
    $PublicIP_RG        = $PublicIP_RG.TrimEnd(',')
    $PublicIP_Location  = $PublicIP_Location.TrimEnd(',')
    $allocation_method  = $allocation_method.TrimEnd(',')
    $sku                = $sku.TrimEnd(',')
    $firewall_name      = $firewall_name.TrimEnd(',')
    $firewall_RG        = $firewall_RG.TrimEnd(',')
    $firewall_location  = $firewall_location.TrimEnd(',')

$variable_creation = @"
VirtualNetworkName           = [$VNET_name]
VirtualNetworkResourceGroup  = [$VNET_RG]
PublicIPName                 = [$PublicIP_Name]
PublicIPResourceGroup        = [$PublicIP_RG]
PublicIPLocation             = [$PublicIP_Location]
AllocationMethod             = [$allocation_method]
SKU                          = [$sku]
FirewallName                 = [$firewall_name]
FirewallResourceGroup        = [$firewall_RG]
FirewallLocation             = [$firewall_location]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################