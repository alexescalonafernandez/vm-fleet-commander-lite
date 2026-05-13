@description('Azure region for virtual machine resources.')
param location string

@description('Number of VMs to create in the fleet.')
param vmCount int

@description('Subnet resource ID where VM NICs will be attached.')
param subnetId string

@description('VM size (for example: Standard_B1s).')
param vmSize string

@description('Admin username for SSH login.')
param adminUsername string

@secure()
@description('SSH public key content for the admin user.')
param adminPublicKey string

@description('Image publisher.')
param imagePublisher string

@description('Image offer.')
param imageOffer string

@description('Image SKU.')
param imageSku string

@description('Image version.')
param imageVersion string

var vmIndexes = range(0, vmCount)
var vmNames = [for i in vmIndexes: 'vm-b2-linux-${padLeft(string(i + 1), 2, '0')}']
var nicNames = [for vmName in vmNames: 'nic-${vmName}']
var publicIpNames = [for vmName in vmNames: 'pip-${vmName}']

resource publicIps 'Microsoft.Network/publicIPAddresses@2023-11-01' = [for (vmName, i) in vmNames: {
  name: publicIpNames[i]
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}]

resource nics 'Microsoft.Network/networkInterfaces@2023-11-01' = [for (vmName, i) in vmNames: {
  name: nicNames[i]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIps[i].id
          }
        }
      }
    ]
  }
}]

resource linuxVms 'Microsoft.Compute/virtualMachines@2023-09-01' = [for (vmName, i) in vmNames: {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: adminPublicKey
            }
          ]
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nics[i].id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}]

output vmNames array = [for i in vmIndexes: linuxVms[i].name]
output nicNames array = [for i in vmIndexes: nics[i].name]
output publicIpResourceNames array = [for i in vmIndexes: publicIps[i].name]
output publicIpAddresses array = [for i in vmIndexes: publicIps[i].properties.ipAddress]
