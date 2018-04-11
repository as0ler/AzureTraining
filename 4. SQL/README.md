# Azure Training

Materials for the Azure Training

Include Materials needed to deploy resources in Azure.


## SQL Server Security

1. Create an SQL Server.
2. Create Azure Database using Adventure Networks Template.
3. Modify Azure SQL Firewall Rules

* To list current firewall rules: 
```
az sql server firewall-rule list --resource-group "training" --server acksqlserver
```

* To add a new firewall rule:
```
az sql server firewall-rule create --resource-group "training" --server acksqlserver --name testrule --start-ip-address 8.8.8.8 --end-ip-address 8.8.8.8
```

* To show new firewall rules: 
```
az sql server firewall-rule show --server acksqlserver  --resource-group "training"  --name testrule
```

4. Using Cloudshell Powershell:
  * Identify the logs of the previous modification. Use Get-AzureRmLog, as the next example:
```
Get-AzureRmLog -StartTime 2018-04-06T00:00 -EndTime 2018-04-07T00:00 -Caller <email> -ResourceId "/subscriptions/<subscriptionid>/resourceGroups/<resourceGroup>/providers/Microsoft.Sql/servers/<SQL Server Name>/firewallRules/"
``` 
  * **Remember to substitute the fields marked as "< foo >".**

5. Enable SQL Vulnerability Scanner.
  * Go to SQL Databases.
  * Select the database to scan.
  * Select Vulnerability Assessment Feature.
  * In settings, configure a storage account to store scan information.
  * Launch the scan.

6. Enable Threat Detection though the related scan result.
	* Select the alert related (SQL Threat DEtection)
	* Click on "remediate".
	* Configure the Threat Detection:
	  * Enable Auditing
	  * Enable Threat Detection
	  * Configure a Storage Account.
	  * Configure an email to receive the alerts.

[Optional]
1. Create a new VM in Azure.
2. Install SQL Management Studio inside the server.
  * Download from https://go.microsoft.com/fwlink/?linkid=870039
3. In SQL databases, select a database previously created.
4. Access to "Set server Firewall".
	* Verify that you don't have any firewall rule created.
	* Verify that "Allow access to Azure services" is disabled.
5. Try to connect to the database from SQL Management Studio.
6. Enable "Allow access to Azure services" and try it again.