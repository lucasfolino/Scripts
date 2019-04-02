SELECT
[database_name] AS "Database",
[backup_start_date],
[type],
AVG([backup_size]/1024/1024/1024) AS "Backup Size GB",
AVG([compressed_backup_size]/1024/1024/1024) AS "Compressed Backup Size GB",
AVG([backup_size]/[compressed_backup_size]) AS "Compression Ratio"
FROM msdb.dbo.backupset
WHERE [database_name] = N''
AND [type] = 'D'
AND backup_start_date >= '01/01/2017'
GROUP BY [database_name],[backup_start_date],[type]
ORDER BY backup_start_date ASC