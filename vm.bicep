param virtualMachines_RGroup_vm_name string = 'RGroup-vm'
param disks_RGroup_vm_OsDisk_1_2bd3c9ea6ee9455bb02dbaf85d2b2032_externalid string = '/subscriptions/e285b4d1-e4e3-4587-b03c-99a6d32d980d/resourceGroups/RGroup/providers/Microsoft.Compute/disks/RGroup-vm_OsDisk_1_2bd3c9ea6ee9455bb02dbaf85d2b2032'
param networkInterfaces_rgroup_vm897_z1_externalid string = '/subscriptions/e285b4d1-e4e3-4587-b03c-99a6d32d980d/resourceGroups/RGroup/providers/Microsoft.Network/networkInterfaces/rgroup-vm897_z1'

resource virtualMachines_RGroup_vm_name_resource 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: virtualMachines_RGroup_vm_name
  location: 'eastus'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_RGroup_vm_name}_OsDisk_1_2bd3c9ea6ee9455bb02dbaf85d2b2032'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: disks_RGroup_vm_OsDisk_1_2bd3c9ea6ee9455bb02dbaf85d2b2032_externalid
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_RGroup_vm_name
      adminUsername: 'adminuser1'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_rgroup_vm897_z1_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
