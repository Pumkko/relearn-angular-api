# What did i learn


## Bicep
Not much to say at the moment, kinda like it

## Deploy from Github Action
used this article : https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=userlevel%2CCLI
did not use open ID Connect because it seems like it requires an organisation on Github which i don't have
so i ran the following script
`az ad sp create-for-rbac --name myApp --role contributor --scopes /subscriptions/{subscription-id}`
replaced myApp with the name of the app
I did not use a resourceGroup here because i want my bicep file to create a specific resource group for my app (for no particular reason, i just wanted to make bicep create the resourcegroup)

## Deploy File
I pretty much copy pasted the samples from the docs, tried different things