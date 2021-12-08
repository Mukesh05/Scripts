# KPMG
## Overview

The 3 tier application architecture setup is provisioned and deployed using Azure Resource Manager(ARM) templates to an Azure subscription.

### Prerequisites
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest#install-or-update)
- [Az PowerShell Module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-2.7.0#install-the-azure-powershell-module-1)
- At least ["Contributor"](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor) role in the target subscriptions

### Assumptions
The solution assumes there is a pre created Resource Group(RG) for networking componets such as load balancers and IP adresses. 
- A separate Resource Group for Networking.
- a key vault that holds the secret for Virtual machines's password
- To access a key vault during template deployment, **enabledForTemplateDeployment** on the key vault to set to **true**.

![KVReference](https://user-images.githubusercontent.com/13200163/145159150-6f241502-3616-4a7e-b86f-c091b3f98626.png)

### Code 
There are two files for deployment
- threeTier.json
- threeTier.parameters.json

### Deployment

  - Pre deployment
    - Create a Resource Group `ThreeTierAppArchitecture` in your subscription
    
    ```PowerShell
    New-AzResourceGroup -Name ThreeTierAppArchitecture -Location CentralIndia
    ```
    ![ResourceGroup](https://user-images.githubusercontent.com/13200163/145163827-4008408c-6f51-4ffd-801c-d3b1658fa124.png)
    
  - During deployment
  
    Azure provides severval ways to deploy ARM templates such as using Azure CLI, using Azure Powershell, through Azure portal among others. 
    I've used cloud Shell and Azure powershell to deploy the ARM templates.
    - Upload both `threeTier.json` and `threeTier.parameters.json` files to cloud drive.
      ![Files](https://user-images.githubusercontent.com/13200163/145167432-d02ab8e8-988d-4635-8bb7-ddf0b01e515e.png)
    - Validate the template using native 
      ``` PowerShell
      Test-AzResourceGroupDeployment -ResourceGroupName "ThreeTierAppArchitecture" `
      -TemplateFile .\threeTier.json -TemplateParameterFile threeTier.parameters.json.json"
      ```



    
    
    
    

  
