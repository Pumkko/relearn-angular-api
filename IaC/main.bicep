targetScope='subscription'

@description('Specifies the location for resources.')
param location string = 'eastus'


resource relearnAngularRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'relearn-angular-rg'
  location: location
}

module webApp 'webapp.bicep' = {
  name: 'webbAppModule'
  scope: relearnAngularRg 
  params: {
    webAppLocation: location
  }
}
