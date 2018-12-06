--https://www.dbdelta.com/sql-server-system-table-statistics-update/
SELECT QUOTENAME(OBJECT_SCHEMA_NAME(i.object_id))+N'.'+QUOTENAME(OBJECT_NAME(i.object_id))+N'.'+QUOTENAME(name) AS index_name,
       STATS_DATE(i.object_id, i.index_id) AS stats_date
FROM sys.indexes AS i
     JOIN sys.partitions AS p ON p.object_id = i.object_id
                                 AND p.index_id = i.index_id
WHERE OBJECTPROPERTYEX(i.object_id, 'IsSystemTable') = 1
      AND i.index_id > 0
      AND p.rows > 0;