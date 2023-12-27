param webAppLocation string
param userAssignedIdentityId string

resource relearnAngularServer 'Microsoft.Sql/servers@2023-05-01-preview' existing = {
  name: 'relearn-angular-server'
}

resource relearnAngularDb 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  name: 'relearn-angular-db'
  location: webAppLocation
  parent: relearnAngularServer
  sku: {
    name: 'Basic'
    size: 'Basic'
    tier: 'Basic'
  }
  properties: {}
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
}
