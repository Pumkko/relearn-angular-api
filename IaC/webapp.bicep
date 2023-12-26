param webAppLocation string


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
  properties: {
    serverFarmId: relearnAngularApiAppServicePlan.id
    httpsOnly: true
    siteConfig: {
      windowsFxVersion: 'DOTNETCORE|7.0'
    }
  }
}

resource relearnAngularAppSourceControl 'Microsoft.Web/sites/sourcecontrols@2023-01-01' = {
  name: 'web'
  parent: relearnAngularApiAppService
  properties: {
    branch: 'main'
    isGitHubAction: true
    repoUrl: 'https://github.com/Pumkko/relearn-angular-api'
  }
}
