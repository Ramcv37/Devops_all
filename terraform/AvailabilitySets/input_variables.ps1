<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	21 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	availability_sets_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create availability sets input variable file.

    .INPUTS
        This script required excel file which contain AvailabilitySets worksheet details.
        
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
[string]$excel_worksheet_name = "AvailabilitySets"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AvailabilitySets" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'AVSET Name'))`
      -or ([string]::IsNullOrEmpty($data.Location))`
       -or ([string]::IsNullOrEmpty($data.'Fault Domain'))`
        -or ([string]::IsNullOrEmpty($data.'Update Domain'))`
         -or ([string]::IsNullOrEmpty($data.'Use Managed Disks')))

    {
        break
    }

    $resource_group       += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $avset_name           += '"' + (($data.'AVSET Name').Trim()) + '"' + ','
    $location             += '"' + (($data.Location).Trim()) + '"' + ','
    $fault_domain         += '"' + ($data.'Fault Domain') + '"' + ','
    $update_domain        += '"' + ($data.'Update Domain') + '"' + ','
    $use_managed_disks    += '"' + ($data.'Use Managed Disks') + '"' + ','
}

if (($resource_group -eq $null) -or ($avset_name -eq $null)`
     -or ($location -eq $null) -or ($fault_domain -eq $null)`
       -or ($update_domain -eq $null) -or ($use_managed_disks -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $resource_group     = $resource_group.TrimEnd(',')
    $avset_name         = $avset_name.TrimEnd(',')
    $location           = $location.TrimEnd(',')
    $fault_domain       = $fault_domain.TrimEnd(',')
    $update_domain      = $update_domain.TrimEnd(',')
    $use_managed_disks  = $use_managed_disks.TrimEnd(',')

$variable_creation = @"
ResourceGroupName   = [$resource_group]
AVSETName           = [$avset_name]
Location            = [$location]
FaultDomain         = [$fault_domain]
UpdateDomain        = [$update_domain]
Managed             = [$use_managed_disks]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################