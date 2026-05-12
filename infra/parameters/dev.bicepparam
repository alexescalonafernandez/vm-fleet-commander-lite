using '../main.bicep'

param location = 'westeurope'
param workloadName = 'b2-vmfleet'
param environmentName = 'dev'
param adminUsername = 'azureuser'
param vmSize = 'Standard_B1s'

// adminPublicKey must be the full public key content, not a filesystem path to a .pub file.
param adminPublicKey = 'REPLACE_WITH_PUBLIC_SSH_KEY_CONTENT'
