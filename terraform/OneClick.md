# :pushpin: Introduction  
:open_file_folder: **Document Version 1.0**

:copyright: Copyright (c) 2021 HCL Technologies

**One Click** is HCL in-house tool which used to deploy multiple Azure Services simultaneously using **Terraform** and **Azure DevOps Release Pipelines**

:rocket: **Please check readme file inside respective azure resource folder**

---

# :pushpin: Environment details

| Microsoft Excel | PowerShell | Terraform | PowerShell Az Module | PowerShell ImportExcel Module | Agent Pool VM |                                  
| ---- | ---- | ---- | ---- | ----- | ---- |
| Latest | 5.1 | 0.14.11 & 1.0.0 | 5.5.0 | 7.1 | Windows 10 |

---

# :pushpin: Agent Pool VM

| **OS Version** | **HostName** | **PowerShell Version** | **PowerShell Az Module** | **Terraform Version** | 
| ---- | ---- | ---- | ---- | ---- |
| Windows 10 | OneClick-Az-Age | 5.1 | 5.5.0 | 0.14.11 |

---

# :pushpin: Configuration File   

**One Click** required configuration excel file which contain infrastructure details e.g. ResourceGroup, VNet, Subnet details and so on.

This configuration file contain multiple worksheets based on Azure Services. Consultant or Enginner need to fill those services details and parameters value

So far following services are included in configuration excel file.

File Name - **Terraform-OneClick.xlsx**

| :white_check_mark: ResourceGroup | :white_check_mark: VirtualNetwork | :white_check_mark: Subnets | :white_check_mark: NSG | 
| ---- | ---- | ---- | ---- |
| :white_check_mark: SecurityRules | :white_check_mark: NSGSubnetAssociation | :white_check_mark: VPNGateway | :white_check_mark: LocalNetworkgateway |
| :white_check_mark: Connections | :white_check_mark: VNETPeering | :white_check_mark: Firewall | :white_check_mark: RouteTable |
| :white_check_mark: AddRoutes | :white_check_mark: Route-Subnet-Association | :white_check_mark: AzureDefender | :white_check_mark: LogAnalytics |
| :white_check_mark: AutomationAccount | :white_check_mark: UpdateManagement | :white_check_mark: AutomationAccount | :white_check_mark: ResourceGroupLock |
| :white_check_mark: AvailabilitySets | :white_check_mark: NetworkInterfaces | :white_check_mark: VirtualMachines | :white_check_mark: Bastion |
| :white_check_mark: RecoveryVault |

---