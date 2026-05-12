using '../main.bicep'

param location = 'westeurope'
param workloadName = 'b2-vmfleet'
param environmentName = 'dev'
param adminUsername = 'azureuser'
param vmSize = 'Standard_B1s'

// adminPublicKey is intentionally not set in this versioned parameter file.
// It must be passed at runtime by the .azcli scripts.

// sshSourceAddressPrefix is intentionally not set in this versioned parameter file.
// It must be passed at runtime by the .azcli scripts.
