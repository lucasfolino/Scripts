SELECT 
 DB_NAME(f.database_id) AS db_name_
,OBJECT_SCHEMA_NAME(f.object_id, database_id) AS schema_name
,OBJECT_NAME(f.object_id, database_id) AS table_name
,[name] AS index_name
,type_desc
,avg_fragmentation_in_percent
,page_count
--,* --pick whatever columns you want now
FROM sys.dm_db_index_physical_stats(NULL, NULL, NULL, NULL, NULL) AS f
JOIN sys.indexes i ON f.object_id = i.object_id AND f.index_id = i.index_id
WHERE index_type_desc <> 'HEAP'
 AND page_count >= 5000
 AND avg_fragmentation_in_percent >= 5
 ORDER BY page_count desc