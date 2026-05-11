@description('Azure region for the virtual machine.')
param location string

@description('VM size (for example: Standard_B1s).')
param vmSize string

@description('Admin username for SSH login.')
param adminUsername string

@secure()
@description('SSH public key content for the admin user.')
param adminPublicKey string

@description('Existing network interface resource ID to attach to the VM.')
param networkInterfaceId string

@description('Image publisher.')
param imagePublisher string

@description('Image offer.')
param imageOffer string

@description('Image SKU.')
param imageSku string

@description('Image version.')
param imageVersion string

resource linuxVm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'vm-b2-linux-01'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'vm-b2-linux-01'
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
          id: networkInterfaceId
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

output vmName string = linuxVm.name
output vmId string = linuxVm.id
