@description('Azure region for all resources.')
param location string

@description('Workload identifier used for tagging and naming context.')
param workloadName string

@description('Environment name (for example: dev, test, prod).')
param environmentName string

@description('Admin username for the Linux VM.')
param adminUsername string

@description('SSH public key content for Linux VM access.')
param adminPublicKey string

@description('Source CIDR allowed to SSH to the VM.')
param sshSourceAddressPrefix string

@description('Azure VM size.')
param vmSize string

@description('Ubuntu image publisher.')
param imagePublisher string = 'Canonical'

@description('Ubuntu image offer.')
param imageOffer string = '0001-com-ubuntu-server-jammy'

@description('Ubuntu image SKU.')
param imageSku string = '22_04-lts-gen2'

@description('Ubuntu image version.')
param imageVersion string = 'latest'

module network 'modules/network.bicep' = {
  name: 'networkDeployment'
  params: {
    location: location
    sshSourceAddressPrefix: sshSourceAddressPrefix
  }
}

module linuxVm 'modules/linux-vm.bicep' = {
  name: 'linuxVmDeployment'
  params: {
    location: location
    vmSize: vmSize
    adminUsername: adminUsername
    adminPublicKey: adminPublicKey
    networkInterfaceId: network.outputs.nicId
    imagePublisher: imagePublisher
    imageOffer: imageOffer
    imageSku: imageSku
    imageVersion: imageVersion
  }
}

output vmName string = linuxVm.outputs.vmName
output publicIpResourceName string = network.outputs.publicIpName
output publicIpAddress string = network.outputs.publicIpAddress
output vnetName string = network.outputs.vnetName
output subnetName string = network.outputs.subnetName
output nsgName string = network.outputs.nsgName
