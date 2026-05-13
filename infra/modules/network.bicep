@description('Azure region for network resources.')
param location string

@description('Source CIDR allowed to SSH to the VM NSG rule.')
param sshSourceAddressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-b2-vmfleet-dev-we-01'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-vms-dev-we-01'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-SSH'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: sshSourceAddressPrefix // Provided by the .azcli workflow at validation/deployment time.
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: 'snet-vms-dev-we-01'
  parent: vnet
  properties: {
    addressPrefix: '10.20.1.0/24'
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

output subnetId string = subnet.id
output vnetName string = vnet.name
output subnetName string = subnet.name
output nsgName string = nsg.name
