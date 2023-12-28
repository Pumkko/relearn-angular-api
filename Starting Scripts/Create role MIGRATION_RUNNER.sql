
use [relearn-angular-db]

CREATE ROLE EF_MIGRATION_RUNNER_ROLE 

GRANT CONTROL ON DATABASE::[relearn-angular-db] TO EF_MIGRATION_RUNNER_ROLE
GRANT CREATE TABLE ON DATABASE::[relearn-angular-db] TO EF_MIGRATION_RUNNER_ROLE
GRANT CREATE FUNCTION ON DATABASE::[relearn-angular-db] TO EF_MIGRATION_RUNNER_ROLE
GRANT CREATE PROCEDURE ON DATABASE::[relearn-angular-db] TO EF_MIGRATION_RUNNER_ROLE
GRANT CREATE VIEW ON DATABASE::[relearn-angular-db] TO EF_MIGRATION_RUNNER_ROLE
SELECT
    perms.state_desc AS State,
    permission_name AS [Permission],
    obj.name AS [on Object],
    dp.name AS [to User Name]
FROM sys.database_permissions AS perms
JOIN sys.database_principals AS dp
    ON perms.grantee_principal_id = dp.principal_id
JOIN sys.objects AS obj
    ON perms.major_id = obj.object_id;