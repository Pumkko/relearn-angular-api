param keyvaultName string
param location string
param useAssignedIdentityObjectId string
param AzureAdTenantIdSecretName string
param AzureAppClientIdSecretName string
param appRegistrationClientId string


resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyvaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        objectId: useAssignedIdentityObjectId
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
  name: AzureAdTenantIdSecretName
  properties: {
    value: subscription().tenantId
  }
}

resource clientIdSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: AzureAppClientIdSecretName
  properties: {
    value: appRegistrationClientId
  }
}
