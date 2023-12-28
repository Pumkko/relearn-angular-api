targetScope='subscription'

@description('Specifies the location for resources.')
param location string = 'eastus'

resource relearnAngularRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'relearn-angular-rg'
  location: location
}

resource sqlResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' existing = {
  name: 'sql-rg'
}



module sqlServerModule 'sqlserver.bicep' = {
  name: 'sqlServerModuule'
  scope: sqlResourceGroup
  params: {
    serverLocation: sqlResourceGroup.location
  }
}

var keyVaultName = 'relearn-angular-kv'
module webAppModule 'webapp.bicep' = {
  name: 'webbAppModule'
  scope: relearnAngularRg 
  params: {
    webAppLocation: location
    sqlDatabaseName: sqlServerModule.outputs.sqlDatabaseName
    sqlServerName: sqlServerModule.outputs.sqlServerName
    keyVaultName: keyVaultName
  }
  dependsOn: [
    sqlServerModule
  ]
}

module keyvaultModule 'keyvault.bicep' = {
  name: 'keyVaultModule'
  scope: relearnAngularRg
  params: {
    location: location
    webAppIdentityPrincipalId: webAppModule.outputs.webAppSystemIdentityPrincipalId
    keyVaultName: keyVaultName
  }
}
