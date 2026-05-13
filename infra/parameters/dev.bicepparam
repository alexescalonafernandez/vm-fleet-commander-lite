using '../main.bicep'

param location = 'westeurope'
param workloadName = 'b2-vmfleet'
param environmentName = 'dev'
param adminUsername = 'azureuser'
param vmSize = 'Standard_B1s'
param vmCount = 2

// Runtime value is provided by the local .azcli workflow via environment variable.
// The real SSH public key content is not hardcoded in version control.
param adminPublicKey = readEnvironmentVariable('ADMIN_PUBLIC_KEY')

// Runtime value is provided by the local .azcli workflow via environment variable.
// The operator public IP prefix is not hardcoded in version control.
param sshSourceAddressPrefix = readEnvironmentVariable('SSH_SOURCE_ADDRESS_PREFIX')
