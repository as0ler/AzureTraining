$input = Get-Content $req -Raw
Out-File -Encoding Ascii -FilePath "D:\home\site\wwwroot\AlertPacketCapturePowershell\output.txt" -inputObject $input


#Import Azure PowerShell modules required to make calls to Network Watcher
Import-Module "D:\home\site\wwwroot\AlertPacketCapturePowershell\azuremodules\AzureRM.Profile\AzureRM.Profile.psd1" -Global
Import-Module "D:\home\site\wwwroot\AlertPacketCapturePowershell\azuremodules\AzureRM.Network\AzureRM.Network.psd1" -Global
Import-Module "D:\home\site\wwwroot\AlertPacketCapturePowershell\azuremodules\AzureRM.Resources\AzureRM.Resources.psd1" -Global

#Process alert request body
$requestBody = Get-Content $req -Raw | ConvertFrom-Json

#Storage account ID to save captures in
$storageaccountid = "/subscriptions/9de0634c-7296-4837-9ac5-6845f367e328/resourceGroups/training/providers/Microsoft.Storage/storageAccounts/packetcaptureacb850"

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
    $nw = Get-AzurermResource | Where {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq 'westeurope'}
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
        New-AzureRmNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher -TargetVirtualMachineId $requestBody.data.context.resourceId -PacketCaptureName $packetCaptureName -StorageAccountId $storageaccountid -TimeLimitInSeconds $packetCaptureDuration
        Out-File -Encoding Ascii -FilePath $res -inputObject "Packet Capture created on ${requestBody.data.context.resourceId}"
    }
}