param webAppLocation string
param sqlServerName string
param sqlDatabaseName string
param keyVaultName string

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
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: relearnAngularApiAppServicePlan.id
    httpsOnly: true
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
          value: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=AzureAdTenantId)'
        }
        {
          name: 'AzureAd:ClientId'
          value: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=RelearnAngularAppClientId)'
        }
      ]
      netFrameworkVersion: 'v8.0'
    }
  }
}

output webAppSystemIdentityPrincipalId string = relearnAngularApiAppService.identity.principalId
