SELECT OBJECT_NAME(S.[OBJECT_ID]) AS [OBJECT NAME], 
       I.[NAME] AS [INDEX NAME], 
       USER_SEEKS, 
       USER_SCANS, 
       USER_LOOKUPS, 
       USER_UPDATES 
FROM   SYS.DM_DB_INDEX_USAGE_STATS AS S 
       INNER JOIN SYS.INDEXES AS I ON I.[OBJECT_ID] = S.[OBJECT_ID] AND I.INDEX_ID = S.INDEX_ID 
WHERE  OBJECTPROPERTY(S.[OBJECT_ID],'IsUserTable') = 1
       AND S.database_id = DB_ID()
	  --AND user_seeks = 0
	  --AND user_scans = 0
	  --AND user_lookups = 0