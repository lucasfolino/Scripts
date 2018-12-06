 /*   Use the dm_db_partition_stats DMV to list all empty tables in your database.   */
   ;WITH Empty AS     
   (
    SELECT 
 OBJECT_NAME(OBJECT_ID) [Table],
 SUM(row_count) [Records]
    FROM 
 sys.dm_db_partition_stats      
    WHERE 
 index_id = 0 OR index_id = 1      
    GROUP BY 
 OBJECT_ID      
   )      

   -- pull it back out
   SELECT [Table],Records 
   FROM [Empty]      
   WHERE [Records] = 0
ORDER BY [Table]