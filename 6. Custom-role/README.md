# Azure Training

Materials for the Azure Training

Include Materials needed to deploy resources in Azure.


## Custom Roles

1. Get the definition of the Role "Reader":
```
Get-AzureRmRoleDefinition -Name "Reader" |ConvertTo-Json"
```

2. Copy the policy in a file called "custom.json".

3. Add a scope to the policy as is shown below. Modify the values subscription and resource group:
```
{
    "Name":  "CustomRole",
    "IsCustom":  true,
    "Description":  "Lets you view everything, but not make any changes.",
    "Actions":  [
                    "*/read"
                ],
    "NotActions":  [

                   ],
    "AssignableScopes":  [
    "/subscriptions/<subscription>/resourceGroups/<ResourceGroup>"
                         ]
}
```
4. Upload the policy to CloudShell Powershell using the Upload button.

5. Get the CloudDrive Path using the command below:
```
Get-CloudDrive
```

6. Create a new role using CloudShell Powershell:
```
New-AzureRmRoleDefinition -InputFile .\custom.json
```

7. Create a new user in Active Directory.

8. In the resource group configured, in IAM blade, add the new role to the new user.

9. Try to start/stop a machine. You could be that is not possible.

10.Now, we are going to modify the policy stored in "custom.json" file, to allow a user to restart, start and stop machines.
  * Modify the file custom.json.
  * Add the actions related to actions "start", "restart", "deallocate" over virtualMachines in Microsoft.Compute provider.


* To get a Microsoft.Compute provider actions, use:
```
Get-AzureRMProviderOperation "Microsoft.Compute/*" | fl Operation
```

11. Get the ID of the policy to modify.
```
Get-AzureRmRoleDefinition -Name 'CustomRole' | ConvertTo-Json
```

12. Add the Id to the custom.json file. 


13. Upload the new policy using "Upload" Button in Cloud Drive.

14. Modify the custom role using CloudShell Powershell:
```
Set-AzureRmRoleDefinition -InputFile .\custom.json
```

15. Logout the custom user and try again to stop a Virtual Machine.


[Optional]
* Create a custom role to manage all Virtual Machine actions, but cannot delete any Virtual Machine.

* Use the next link as a reference: 
  * https://docs.microsoft.com/es-es/azure/active-directory/role-based-access-control-resource-provider-operations

