use [relearn-angular-db]

CREATE USER EF_MIGRATION_RUNNER FOR LOGIN EF_MIGRATION_RUNNER;  
GO   


ALTER ROLE EF_MIGRATION_RUNNER_ROLE add member EF_MIGRATION_RUNNER