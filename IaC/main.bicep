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

module userIdentityModule 'userAssignedIndentity.bicep' = {
  name: 'relearnAngularIdentityModule'
  params: {
    webAppLocation: location
  }
  scope: relearnAngularRg
}

module keyvaultModule 'keyvault.bicep' = {
  name: 'keyVaultModule'
  scope: relearnAngularRg
  params: {
    location: location
    userAssignedIdentityId: userIdentityModule.outputs.userAssignedIdentityPrincipalId
  }
}

module sqlServer 'sqlserver.bicep' = {
  name: 'sqlServerModuule'
  scope: sqlResourceGroup
  params: {
    serverLocation: sqlResourceGroup.location
  }
}


module webApp 'webapp.bicep' = {
  name: 'webbAppModule'
  scope: relearnAngularRg 
  params: {
    webAppLocation: location
    keyvaultName: keyvaultModule.outputs.keyVaultName
    userAssignedIdentityId: userIdentityModule.outputs.userAssignedIdentityId
    sqlDatabaseName: sqlServer.outputs.sqlDatabaseName
    sqlServerName: sqlServer.outputs.sqlServerName
  }
  dependsOn: [
    userIdentityModule
    keyvaultModule
  ]
}

