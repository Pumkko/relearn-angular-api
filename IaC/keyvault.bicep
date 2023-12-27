param location string
param userAssignedIdentityId string
param appRegistrationClientId string

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

resource tenantIdSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'AzureTenantId'
  properties: {
    value: subscription().tenantId
  }
}

resource clientIdSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'AzureAppClientId'
  properties: {
    value: appRegistrationClientId
  }
}

output tenantIdSecretName string = tenantIdSecret.name
output clientIdSecretName string = clientIdSecret.name
output keyVaultName string = keyVault.name
