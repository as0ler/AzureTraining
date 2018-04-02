# AzureTraining
Materials for the Azure Training

Include Materials needed to deploy resources in Azure. 

## Monitor Alert
1. To Create a monitor alert execute the command listed above:
```
New-AzureRmResourceGroupDeployment -Name "HealthCheck" -ResourceGroupname "training" -TemplateUri "https://raw.githubus
ercontent.com/as0ler/AzureTraining/master/monitor-servicehealth-alert/azuredeploy.json"
```
2. Check Monitor to see the new Service Health Alert.
