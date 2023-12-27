param webAppLocation string

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'relearnAngularRgWebAppKvIdentity'
  location: webAppLocation
}

output userAssignedIdentityPrincipalId string = userAssignedIdentity.properties.principalId
output userAssignedIdentityId string = userAssignedIdentity.id
