param webAppLocation string
param keyvaultName string
param userAssignedIdentityId string
param sqlServerName string
param sqlDatabaseName string

resource relearnAngularApiAppServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'relearn-angular-service-plan'
  location: webAppLocation
  sku: {
    name: 'F1'
  }
  kind: 'windows'
}

resource relearnAngularApiAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'relearn-angular-app'
  location: webAppLocation
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    serverFarmId: relearnAngularApiAppServicePlan.id
    httpsOnly: true
    keyVaultReferenceIdentity: userAssignedIdentityId
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
          value: '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=AzureAdTenantId)'
        }
        {
          name: 'AzureAd:ClientId'
          value: '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=RelearnAngularAppClientId)'
        }
      ]
      connectionStrings: [
        {
          name: 'relearnAngularDbConnectionString'
          connectionString: 'Data Source=${sqlServerName}.database.windows.net;Initial Catalog=${sqlDatabaseName}; Authentication=Active Directory Default; Encrypt=True;'
          type: 'SQLAzure'
        }
      ]
      netFrameworkVersion: 'v8.0'
    }
  }
}
