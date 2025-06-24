DECLARE @User NVARCHAR(500)
SET @User = 'userone'
SELECT -- other permissions
	dbperm.class_desc,
	dbperm.permission_name,
	dbperm.state_desc,
	object_schema_name(dbperm.major_id) as schema_name,
	object_name(dbperm.major_id) as resource_name,
	dbprin.name as principal_name
FROM sys.database_principals dbprin
INNER JOIN sys.database_permissions dbperm ON dbperm.grantee_principal_id = dbprin.principal_id
WHERE dbprin.name like concat('%', @User, '%') AND dbperm.permission_name not in ('EXECUTE')
order by principal_name