# What did i learn

## Bicep
Not much to say at the moment, kinda like it, it does have limitations though, because it only supports Azure, I found examples online that created ressources on Azure et then used Terraform to create new Github secrets from the created ressources

## Deploy from Github Action
used this article : https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=userlevel%2CCLI
did not use open ID Connect because it was at first simpler to use credentials, i'll have to check that later though

`az ad sp create-for-rbac --name myApp --role contributor --scopes /subscriptions/{subscription-id} --sdk-auth`
I did not use a resourceGroup here because i want my bicep file to create a specific resource group for my app (for no particular reason, i just wanted to make bicep create the resourcegroup)

This says --sdk-auth is deprecated it's okay though the doc is pretty clear about what we need:  
https://github.com/azure/login?tab=readme-ov-file#login-with-a-service-principal-secret

creds must be a JSON with the following format : 
```
{
    "clientSecret":  "******",
    "subscriptionId":  "******",
    "tenantId":  "******",
    "clientId":  "******"
}
```



## Deploy File
I pretty much copy pasted the samples from the docs, tried different things

### Database connection

We need to add a new DB User with the name of the app it can be done using this command
`az webapp connection create sql -g "relearn-angular-rg" -n "relearn-angular-app" --tg "sql-rg" --server "relearn-angular-server" --database "relearn-angular-db" --system-identity`

from this doc : 
https://learn.microsoft.com/en-us/azure/azure-sql/database/azure-sql-dotnet-entity-framework-core-quickstart?view=azuresql&tabs=visual-studio%2Cazure-portal%2Cportal

To integrate this as a build step i could have: 
- Created a user on the databse with the permission to add new user and login
- Run a `azure/sql-action` with the following script 
    ```
    CREATE USER <your-app-service-name> FROM EXTERNAL PROVIDER;
    ALTER ROLE db_datareader ADD MEMBER <your-app-service-name>;
    ALTER ROLE db_datawriter ADD MEMBER <your-app-service-name>;
    ALTER ROLE db_ddladmin ADD MEMBER <your-app-service-name>;
    GO
    ```
I also needed to add a new Login and user to allow the build to deploy the migration file. right now i created the login by hand but i could have added a step that : 
- Create a new Login and User for the migration runner if it does not exist
- Create the EF_MIGRATION_RUNNER_ROLE if it does not exist
- Run the migration with the newly created user
The files in the starting script folder are a good starting if i ever want to do that



