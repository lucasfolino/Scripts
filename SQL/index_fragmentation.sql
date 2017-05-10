SELECT 
 DB_NAME(f.database_id) AS db_name_
,OBJECT_SCHEMA_NAME(object_id, database_id) AS schema_name
,OBJECT_NAME(object_id, database_id) AS table_name
,* --pick whatever columns you want now
FROM sys.dm_db_index_physical_stats(NULL, NULL, NULL, NULL, NULL) AS f
WHERE index_type_desc <> 'HEAP'
 AND page_count > 1000
 AND avg_fragmentation_in_percent > 5