# AzureTraining
Materials for the Azure Training

Include Materials needed to deploy resources in Azure.

## Enabling Packet Capture via an alert

0. Enable Network Watcher in your region.

1. Create an Azure Function.
  * Use a unique name.
  * Type: Windows

2. Create a new Function App.
  * Type: HttpTrigger-Powershell
  * Language: Powershell
  * Name: AlertPacketCapturePowerShell
  * Auth: Function

3. Try the Function. Execute the 'Run' command.

4. Add the next modules to the function inside a folder called "azuremodules", using App Service Editor:
  * AzureRM.Network
  * AzureRM.Profile
  * AzureRM.Resources

5. Create a new App in Active Directory.
  * Select a Name (f.ex. Automation_Example)
  * Type: Web app
  * Select an URL (f.ex. http://example.org)

6. In App Registration Settings, create a Key:
  * Create a new Key.
  * Define a duration.
  * Copy the value once saved.

7. In "IAM" blade from the subscription used:
  * Go to "subscriptions" panel.
  * Select your subscription.
  * Go to "IAM" blade.
  * Add a new permission.
  * Add the application as "Owner".

8. Obtain the tenant id in Active Directory:
  * Active Directory -> Properties
  * Copy the value "DirectoryID"

9. Create the next Environment variables:
  * Go to App Services
  * Select your function, and go to "Platform features".
  * Select "Application settings"
  * In "Application settings" section, create the next environment variables:
    * AzureTenant
    * AzureCredPassword
    * AzureClientId

10. Create a virtual Machine:
  * Type: Ubuntu Linux
  * Name: testMachine
  * In "Extensions blade", enable the Extension Network Watcher.

11. Create a new Managed Rule (Monitor -> Alerts)
  * Target: testMachine
  * Criteria: NetworkIn
  * Threshold: 1 byte
  * Period: 1 minute
  * Frequency: 1 minute
  * Alert Name: Exceeded Inbound Traffic
  * Description: Exceeded Inbound Traffic
  * New Action Group: 
    * Name: CaptureAutomation
    * ShortName: Capture
    * ResourceGroup: training
    * Action Name: CaptureDispatch
    * URL: Function URL

12. Add the next script and modify, without "<" ">" the next variables:
  * funcion_name: Function Name
  * StorageAccountId: Storage Account URL where captures will be stored.

```
$input = Get-Content $req -Raw
Out-File -Encoding Ascii -FilePath "D:\home\site\wwwroot\AlertPacketCapturePowershell\output.txt" -inputObject $input


#Import Azure PowerShell modules required to make calls to Network Watcher
Import-Module "D:\home\site\wwwroot\<function_name>\azuremodules\AzureRM.Profile\AzureRM.Profile.psd1" -Global
Import-Module "D:\home\site\wwwroot\<function_name>\azuremodules\AzureRM.Network\AzureRM.Network.psd1" -Global
Import-Module "D:\home\site\wwwroot\<function_name>\azuremodules\AzureRM.Resources\AzureRM.Resources.psd1" -Global

#Process alert request body
$requestBody = Get-Content $req -Raw | ConvertFrom-Json

#Storage account ID to save captures in
$storageaccountid = "<StorageAccountId>"

#Packet capture vars
$packetcapturename = "AutomationCapture"
$packetCaptureLimit = 10
$packetCaptureDuration = 10

#Credentials
$tenant = $env:AzureTenant
$pw = $env:AzureCredPassword
$clientid = $env:AzureClientId

#Authentication
$secpassword = ConvertTo-SecureString $pw -AsPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential ($clientid, $secpassword)
Add-AzureRMAccount -ServicePrincipal -Tenant $tenant -Credential $credential

#Get the VM that fired the alert
if($requestBody.data.context.resourceType -eq "Microsoft.Compute/virtualMachines")
{
    Write-Output ("Subscription ID: {0}" -f $requestBody.data.context.subscriptionId)
    Write-Output ("Resource Group:  {0}" -f $requestBody.data.context.resourceGroupName)
    Write-Output ("Resource Name:  {0}" -f $requestBody.data.context.resourceName)
    Write-Output ("Resource Type:  {0}" -f $requestBody.data.context.resourceType)

    #Get the Network Watcher in the VM's region
    $nw = Get-AzurermResource | Where {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq $requestBody.context.resourceRegion}
    $networkWatcher = Get-AzureRmNetworkWatcher -Name $nw.Name -ResourceGroupName $nw.ResourceGroupName

    #Get existing packetCaptures
    $packetCaptures = Get-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher

    #Remove existing packet capture created by the function (if it exists)
    $packetCaptures | %{if($_.Name -eq $packetCaptureName)
    { 
        Remove-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher -PacketCaptureName $packetCaptureName
    }}

    #Initiate packet capture on the VM that fired the alert
    if ((Get-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher).Count -lt $packetCaptureLimit){
        echo "Initiating Packet Capture"
        New-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher -TargetVirtualMachineId $requestBody.context.resourceId -PacketCaptureName $packetCaptureName -StorageAccountId $storageaccountid -TimeLimitInSeconds $packetCaptureDuration
        Out-File -Encoding Ascii -FilePath $res -inputObject "Packet Capture created on ${requestBody.context.resourceID}"
    }
}
```

## Notes 
To test the function, you can use the next test alert:

```
curl -vX POST "<URL Function>" -d @request.json --header "Content-Type: application/json" -vvvvv
```
