targetScope='subscription'

@secure()
param appRegistrationClientId string

@description('Specifies the location for resources.')
param location string = 'eastus'


resource relearnAngularRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'relearn-angular-rg'
  location: location
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
    appRegistrationClientId: appRegistrationClientId
  }
}


module webApp 'webapp.bicep' = {
  name: 'webbAppModule'
  scope: relearnAngularRg 
  params: {
    webAppLocation: location
    azureAdTenantIdSecretName: keyvaultModule.outputs.tenantIdSecretName
    azureAppClientIdSecretName: keyvaultModule.outputs.clientIdSecretName
    keyvaultName: keyvaultModule.outputs.keyVaultName
    userAssignedIdentityId: userIdentityModule.outputs.userAssignedIdentityId
  }
  dependsOn: [
    userIdentityModule
    keyvaultModule
  ]
}


module sqlServer 'sqlserver.bicep' = {
  name: 'sqlServerModuule'
  scope: relearnAngularRg
  params: {
    webAppLocation: location
    userAssignedIdentityId: userIdentityModule.outputs.userAssignedIdentityId
  }
  dependsOn: [
    userIdentityModule
  ]
}
