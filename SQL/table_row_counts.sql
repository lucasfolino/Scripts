--https://stackoverflow.com/questions/2221555/how-to-fetch-the-row-count-for-all-tables-in-a-sql-server-database

SELECT t.name,
       FORMAT(s.row_count, 'N0') AS rows
FROM sys.tables t
     JOIN sys.dm_db_partition_stats s ON t.object_id = s.object_id
                                         AND t.type_desc = 'USER_TABLE'
--AND t.name not like '%dss%'
                                         AND s.index_id IN(0, 1)
ORDER BY row_count DESC;




