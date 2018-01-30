select DB_NAME(t.database_id)		as [DBName]
	 , SCHEMA_NAME(obj.schema_id)	as [SchemaName]
	 , OBJECT_NAME(t.object_id)		as [ObjectName]
	 , obj.Type						as [ObjectType]
	 , obj.Type_Desc				as [ObjectTypeDesc]
	 , ind.name						as [IndexName]
	 , ind.Type						as IndexType
	 , ind.Type_Desc				as IndexTypeDesc
	 , ind.Is_Unique				as IndexIsUnique
	 , ind.is_primary_key			as IndexIsPK
	 , ind.is_unique_constraint		as IndexIsUniqueConstraint
	 , t.[Database_ID]
	 , t.[Object_ID]
	 , t.[Index_ID]
	 , t.Last_User_Seek
	 , t.Last_User_Scan
	 , t.Last_User_Lookup
	 , t.Last_System_Seek
	 , t.Last_System_Scan
	 , t.Last_System_Lookup
from sys.dm_db_index_usage_stats as t
inner join sys.objects as obj on t.[object_id]=obj.[object_id]
inner join sys.indexes as ind on t.[object_id]=ind.[object_id] and t.index_id=ind.index_id
where (last_user_seek	is null or last_user_seek		<dateadd(year,-1,getdate()))
and (last_user_scan		is null or last_user_scan		<dateadd(year,-1,getdate()))
and (last_user_lookup	is null or last_user_lookup		<dateadd(year,-1,getdate()))
and (last_system_seek	is null or last_system_seek		<dateadd(year,-1,getdate()))
and (last_system_scan	is null or last_system_scan		<dateadd(year,-1,getdate()))
and (last_system_lookup is null or last_system_lookup	<dateadd(year,-1,getdate()))
and t.database_id>4 and t.[object_id]>0 -- system databases are excluded