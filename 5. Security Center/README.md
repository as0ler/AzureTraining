# Azure Training

Materials for the Azure Training

Include Materials needed to deploy resources in Azure.


## Azure Security Center

We are going to use Azure Security Center.

### Just-in-time Access
1. Create a resource group called "Linux rsc".
2. Create a new VM Linux in the Resource Group.
3. Go to Security Center.
4. In Security Policy, princing tier, select "Standard".
5. Go to Security Center - Just-in-time VM Access.
6. Go to "Recommended", and Enable JIT on the Linux Machine recently created.
7. Review the ports configured, and configure a new one if desire.
8. Go to "Configured", and click on "Request access".
9. Enable Access to port 22 from your source IP for 1 hour.
10. Verify the rules configured in the NSG in the Linux Machine. 