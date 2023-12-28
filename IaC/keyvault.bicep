param location string
param userAssignedIdentityId string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'relearn-angular-kv'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        objectId: userAssignedIdentityId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
        tenantId: subscription().tenantId
      }
    ] 
  }
}

output keyVaultName string = keyVault.name
