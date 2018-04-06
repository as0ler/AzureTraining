# Azure Training

Materials for the Azure Training

Include Materials needed to deploy resources in Azure.


## SQL Server Security

1. Create SQL Server.
2. Create Azure Database using Adventure Networks Template.
3. Modify Azure SQL Firewall Rules

```
az sql server firewall-rule list --resource-group "training" --server acksqlserver
```

```
az sql server firewall-rule create --resource-group "training" --server acksqlserver --name testrule --start-ip-address 8.8.8.8 --end-ip-address 8.8.8.8
```

```
az sql server firewall-rule show --server acksqlserver  --resource-group "training"  --name testrule
```

4. Using Cloudshell Powershell:
  * Identify the logs of the previous modification. Use Get-AzureRmLog, as the next example:
```
Get-AzureRmLog -StartTime 2018-04-06T00:00 -EndTime 2018-04-07T00:00 -Caller <email> -ResourceId "/subscriptions/<subscriptionid>/resourceGroups/<resourceGroup>/providers/Microsoft.Sql/servers/<SQL Server Name>/firewallRules/"
``` 
  * **Remember to substitute the fields marked as "< foo >". **

 5. Enable SQL Vulnerability Scanner.