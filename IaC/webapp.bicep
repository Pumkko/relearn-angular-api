param webAppLocation string


var keyvaultName = 'relearn-angular-kv'
var azureAdTenantIdSecretName = 'AzureTenantId'
var azureAppClientIdSecretName = 'AzureAppClientId'
var userAssignedIdentityName = 'relearnAngularRgWebAppKvIdentity'


// create user assigned managed identity
resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedIdentityName
  location: webAppLocation
}


resource relearnAngularApiAppServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'relearnAngularApiPlan'
  location: webAppLocation
  sku: {
    name: 'F1'
  }
  kind: 'windows'
}

resource relearnAngularApiAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'relearnAngularApp'
  location: webAppLocation
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  properties: {
    serverFarmId: relearnAngularApiAppServicePlan.id
    httpsOnly: true
    keyVaultReferenceIdentity: userAssignedIdentity.id
    siteConfig: {
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
      appSettings: [
        {
          name: 'AzureAd:TenantId'
          value: '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=${azureAdTenantIdSecretName})'
        }
        {
          name: 'AzureAd:ClientId'
          value: '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=${azureAppClientIdSecretName})'
        }
      ]
      netFrameworkVersion: 'v8.0'
    }
  }
}

module keyvault 'keyvault.bicep' = {
  name: 'keyVaultModule'
  params: {
    keyvaultName: keyvaultName
    location: webAppLocation
    AzureAdTenantIdSecretName: azureAdTenantIdSecretName
    AzureAppClientIdSecretName: azureAppClientIdSecretName
    useAssignedIdentityObjectId: userAssignedIdentity.properties.principalId
  }
}
