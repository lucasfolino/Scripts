 --http://www.sqlfingers.com/2014/02/find-unused-tables-in-sql-server.html
 SELECT        
       ao.[name] [Table],
       s.[name] [Schema],
       [create_date] [Created],
       [modify_date] [LastModified]
   FROM
        sys.all_objects ao JOIN sys.schemas s
          ON ao.schema_id = s.schema_id
   WHERE
        OBJECT_ID NOT IN (
             SELECT OBJECT_ID
             FROM sys.dm_db_index_usage_stats
       )
       AND [type] = 'U'
	  --AND modify_date < '1/1/2018'
   ORDER BY
      [Table]