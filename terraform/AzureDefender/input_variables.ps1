<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	07 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	azure_defender_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create azure defender input variable file.

    .INPUTS
        This script required excel file which contain AzureDefender worksheet details.
        
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
[string]$excel_worksheet_name = "AzureDefender"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AzureDefender" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.VirtualMachines))`
     -or ([string]::IsNullOrEmpty($data.SqlServers))`
      -or ([string]::IsNullOrEmpty($data.AppServices))`
       -or ([string]::IsNullOrEmpty($data.StorageAccounts))`
        -or ([string]::IsNullOrEmpty($data.SqlServerVirtualMachines))`
         -or ([string]::IsNullOrEmpty($data.KubernetesService))`
          -or ([string]::IsNullOrEmpty($data.ContainerRegistry))`
           -or ([string]::IsNullOrEmpty($data.KeyVaults)))
          #  -or ([string]::IsNullOrEmpty($data.Dns))`
           #   -or ([string]::IsNullOrEmpty($data.Arm)))

    {
        break
    }

    $VirtualMachines            += '"' + (($data.VirtualMachines).Trim()) + '"' + ','
    $SqlServers                 += '"' + (($data.SqlServers).Trim()) + '"' + ','
    $AppServices                += '"' + (($data.AppServices).Trim()) + '"' + ','
    $StorageAccounts            += '"' + (($data.StorageAccounts).Trim()) + '"' + ','
    $SqlServerVirtualMachines   += '"' + (($data.SqlServerVirtualMachines).Trim()) + '"' + ','
    $KubernetesService          += '"' + (($data.KubernetesService).Trim()) + '"' + ','
    $ContainerRegistry          += '"' + (($data.ContainerRegistry).Trim()) + '"' + ','
    $KeyVaults                  += '"' + (($data.KeyVaults).Trim()) + '"' + ','
   # $Dns                        += '"' + (($data.Dns).Trim()) + '"' + ','
   # $Arm                        += '"' + (($data.Arm).Trim()) + '"' + ','
}

if (($VirtualMachines -eq $null) -or ($SqlServers -eq $null)`
     -or ($AppServices -eq $null) -or ($StorageAccounts -eq $null)`
       -or ($SqlServerVirtualMachines -eq $null) -or ($KubernetesService -eq $null) -or ($ContainerRegistry -eq $null) -or ($KeyVaults -eq $null))
         #-or ($Dns -eq $null) -or ($Arm -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$tier = $VirtualMachines + $SqlServers + $AppServices + $StorageAccounts + $SqlServerVirtualMachines`
        + $KubernetesService + $ContainerRegistry + $KeyVaults + $Dns + $Arm

$tier = $tier.TrimEnd(',')

$variable_creation = @"
Tier           = [$tier]
ResourceType   = ["VirtualMachines","SqlServers","AppServices","StorageAccounts","SqlServerVirtualMachines","KubernetesService","ContainerRegistry","KeyVaults"]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################