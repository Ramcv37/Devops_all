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
	 Filename:     	security_rules_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create security rules input variable file.

    .INPUTS
        This script required excel file which contain NSGSecurityRules details.
        
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
[string]$excel_worksheet_name = "NSGSecurityRules"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "NSGSecurityRules" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing NSG Resource Group Name')) -or ([string]::IsNullOrEmpty($data.'Existing NSG Name')) -or ([string]::IsNullOrEmpty($data.'Security Rule Name')))
    {
        break
    }

    if (($data.'Source Port Range') -is [int] -or $data.($data.'Source Port Range') -is [double]) {
        $destport = (($data.'Destination Port Range').Trim())
    } 
    else {
        $destport = ($data.'Destination Port Range')
    }
    $rgname                     += '"' + (($data.'Existing NSG Resource Group Name').Trim()) + '"' + ','
    $NSGName                    += '"' + (($data.'Existing NSG Name').Trim()) + '"' + ','
    $Security_rule_name         += '"' + (($data.'Security Rule Name').Trim()) + '"' + ','
    $Priority                   += '"' + (($data.Priority)) + '"' + ','
    $Direction                  += '"' + (($data.Direction).Trim()) + '"' + ','
    $Access                     += '"' + (($data.Access).Trim()) + '"' + ','
    $Protocol                   += '"' + (($data.Protocol)) + '"' + ','
    $Source_port_range          += '"' + (($data.'Source Port Range').Trim()) + '"' + ','
    $Destination_port_range     += '"' + ($destport) + '"' + ','
    $Source_address_prefix      += '"' + (($data.'Source Address Prefix').Trim()) + '"' + ','
    $Destination_address_prefix += '"' + (($data.'Destination Address Prefix').Trim()) + '"' + ','


}


if (($rgname -eq $null) -or ($NSGName -eq $null) -or ($Security_rule_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$rgname                     = $rgname.TrimEnd(',')
$NSGName                    = $NSGName.TrimEnd(',')
$Security_rule_name         = $Security_rule_name.TrimEnd(',')
$Priority                   = $Priority.TrimEnd(',')
$Direction                  = $Direction.TrimEnd(',')
$Access                     = $Access.TrimEnd(',')
$Protocol                   = $Protocol.TrimEnd(',')
$Source_port_range          = $Source_port_range.TrimEnd(',')
$Destination_port_range     = $Destination_port_range.TrimEnd(',')
$Source_address_prefix      = $Source_address_prefix.TrimEnd(',')
$Destination_address_prefix = $Destination_address_prefix.TrimEnd(',')


$variable_creation = @"
NSGName                  = [$NSGName]
NSGResourceGroupName     = [$rgname]
SecurityRuleName         = [$Security_rule_name]
Priority                 = [$Priority]
Direction                = [$Direction]
Access                   = [$Access]
Protocol                 = [$Protocol]
SourcePortRange          = [$Source_port_range]
DestinationPortRange     = [$Destination_port_range]
SourceAddressPrefix      = [$Source_address_prefix]
DestinationAddressPrefix = [$Destination_address_prefix]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################