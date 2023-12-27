param webAppLocation string


resource relearnAngularApiAppServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'relearnAngularApiPlan'
  location: webAppLocation
  sku: {
    name: 'F1'
  }
  kind: 'linux'
}

resource relearnAngularApiAppService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'relearnAngularApp'
  location: webAppLocation
  properties: {
    serverFarmId: relearnAngularApiAppServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}
