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

@description('Number of VMs to create in the fleet.')
param vmCount int

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

module linuxVmFleet 'modules/linux-vm.bicep' = {
  name: 'linuxVmFleetDeployment'
  params: {
    location: location
    vmCount: vmCount
    subnetId: network.outputs.subnetId
    vmSize: vmSize
    adminUsername: adminUsername
    adminPublicKey: adminPublicKey
    imagePublisher: imagePublisher
    imageOffer: imageOffer
    imageSku: imageSku
    imageVersion: imageVersion
  }
}

output vmNames array = linuxVmFleet.outputs.vmNames
output publicIpResourceNames array = linuxVmFleet.outputs.publicIpResourceNames
output publicIpAddresses array = linuxVmFleet.outputs.publicIpAddresses
output nicNames array = linuxVmFleet.outputs.nicNames
output vnetName string = network.outputs.vnetName
output subnetName string = network.outputs.subnetName
output nsgName string = network.outputs.nsgName
