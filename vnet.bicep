// Parameters for Virtual Network
param location string = resourceGroup().location
param resourceGroupName string

// Define Virtual Network and Subnets
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: '${resourceGroupName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'public-subnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'private-subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

// Outputs
output vnetId string = vnet.id
