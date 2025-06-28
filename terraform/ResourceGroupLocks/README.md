# :pushpin: Resource Group Locks
:open_file_folder: **Document Version 1.0**  

This Azure Release Pipeline is using Terraform to create **Resource Group Locks**

---
# :pushpin: Azure Repo File Details

| :file_folder: **File Name** | :capital_abcd: **Language** |
| ---- | ---- |
| :white_check_mark: resource_group_locks_creation.tf | Terraform |
| :white_check_mark: resource_group_locks_variables.tf | Terraform |
| :white_check_mark: resource_group_locks_input_variables.ps1 | PowerShell |

---

# :pushpin: Version Details

| **Terraform** | **PowerShell** | **ImportExcel Module** | **Azure Provider** |
| ----| ---- | ---- | ---- | 
| 0.14.11 | 5.1 | 7.1.1 | 2.40.0 |

# :pushpin: Download Link

:link: [Terraform](https://releases.hashicorp.com/terraform/0.14.11/)

:link: [Terraform Extension for Azure DevOps](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

:link: [PowerShell ImportExcel](https://www.powershellgallery.com/packages/ImportExcel/7.1.1)

```powershell
Install-Module -Name ImportExcel -RequiredVersion 7.1.1
```
---

# :pushpin: Execution Approach

:package: **Task 1**

**PowerShell Script** - resource_group_locks_input_variables.ps1

1. This script required ImportExcel PowerShell module to capture excel file "ResourceGroupLocks" worksheet data.
2. Script will convert worksheet data to Terraform.tfvars file.
3. It will save terraform.tfvars file in "ResourceGroupLocks" configuration directory

:package: **Task 2**

**Install Terraform** - [Terraform Extension for Azure DevOps](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

1. This extension will help you to install Terraform with specific version if its not already installed.

:package: **Task 3**

**Terraform init** - [Terraform Extension for Azure DevOps](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

:link: **Documentation** - [Check Terraform init Documentation](https://www.terraform.io/docs/cli/init/index.html)

:heavy_check_mark: _Azure Backend Configuration for Terraform State File_

<table style="width:100%">
  <tr>
    <th><b> Subscription</b></th>
    <td>Service Principal</td>
  </tr>
  <tr>
    <th><b>Storage Account Resource Group</b></th>
    <td>RG-Automation</td>
  </tr>
  <tr>
    <th><b>Storage Account Name</b></th>
    <td>msdemo</td>
  </tr>
   <tr>
    <th><b>Container Name</b></th>
    <td>terraformstate</td>
  </tr>
  <tr>
    <th><b>Key (Terraform State File Name)</b></th>
    <td>resource-group-locks.tfstate</td>
  </tr>
  <tr>
    <th><b>Configuration Directory</b></th>
    <td>$(System.DefaultWorkingDirectory)/_Terraform-OneClick/ResourceGroupLocks</td>
  </tr>
</table>

:package: **Task 4**

**Terraform apply** - [Terraform Extension for Azure DevOps](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

:link: **Documentation** - [Check Terraform apply Documentation](https://www.terraform.io/docs/cli/commands/apply.html)

<table style="width:100%">
  <tr>
    <th><b> Subscription</b></th>
    <td>Service Principal</td>
  </tr>
  <tr>
    <th><b>Configuration Directory</b></th>
    <td>$(System.DefaultWorkingDirectory)/_Terraform-OneClick/ResourceGroupLocks</td>
  </tr>
</table>

---

# :pushpin: Version Control History

| **Version** | **Comments** |
| ---- | ---- | ---- |
| 1.0 | Created main terraform and powershell files |

---