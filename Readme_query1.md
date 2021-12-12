# Query1
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

### Architecture
A single ARM template is used to deploy a three tier application architecture to a single resource group.

![image](https://user-images.githubusercontent.com/13200163/145585460-6cdf628c-db7b-48ef-8727-18eed0d4dbc0.png)

The ARM template deployes the below Azure resources to achieve the desired state of a three tier application infrastructure. The infrastructure deployed consists of a
virtual machine, a storage account, an availability set, a load balancer and networking components for each tier. 
Below diagram shows the visual representation of the ARM template.

![image](https://user-images.githubusercontent.com/13200163/145711895-ca08750a-9d67-41b4-806b-d19fc15cc89f.png)

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
      ![upload](https://user-images.githubusercontent.com/13200163/145169955-342c4580-4945-4700-bec5-0e6a561fe515.png)
      
    - Validate the template using `Test-AzResourceGroupDeployment` cmdlet that determines whether an Azure resource group deployment template and its parameter values are       valid. 
      ``` PowerShell
      Test-AzResourceGroupDeployment -ResourceGroupName "ThreeTierAppArchitecture" `
      -TemplateFile ./threeTier.json -TemplateParameterFile ./threeTier.parameters.json.json"
      ```
      ![Validate](https://user-images.githubusercontent.com/13200163/145169700-6f7b319f-61c5-41a3-8e14-c323122f9c9d.png)
      
    - Deploy the template using `New-AzResourceGroupDeployment` cmdlet
      ``` PowerShell
      New-AzResourceGroupDeployment -Name threeTierAppInfraDeployment -ResourceGroupName "ThreeTierAppArchitecture" `
      -TemplateFile ./threeTier.json -TemplateParameterFile ./threeTier.parameters.json.json"
      ```
      ![Deployment](https://user-images.githubusercontent.com/13200163/145711486-ef284daa-ba54-452a-9f8c-6e2236a938cd.png)

      
   - Post Deployment
   
      - Screenshots
      
     ![PostDeployment](https://user-images.githubusercontent.com/13200163/145176683-4dd58a91-7665-4373-9938-1c1ee3180fb6.png)
     
     ![Portalview](https://user-images.githubusercontent.com/13200163/145177071-47640b75-64e1-4794-ba66-a2ca57c089bd.png)
     
     ![image](https://user-images.githubusercontent.com/13200163/145197625-50cd5025-d9b4-4a8b-b279-4d60e3098208.png)




      




    
    
    
    

  
