param location string = resourceGroup().location
param resourceGroupName string 
// Step 3: Define AKS Cluster in Private Subnet
resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-01-01' = {
  name: '${resourceGroupName}-aks'
  location: location
  properties: {
    dnsPrefix: '${resourceGroupName}-aks-dns'
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: 3
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
        vnetSubnetID: resourceId('Microsoft.Network/virtualNetworks/subnets', '${resourceGroupName}-vnet', 'private-subnet')

      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '10.0.3.0/24'
      dnsServiceIP: '10.0.3.10'
      dockerBridgeCidr: '172.17.0.1/16'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
//output
output aksClusterId string = aksCluster.id
