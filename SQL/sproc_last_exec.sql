SELECT  p.object_id, d.database_id, p.name, 
d.cached_time, d.last_execution_time, d.total_elapsed_time,
d.total_elapsed_time/d.execution_count AS [avg_elapsed_time],
d.last_elapsed_time, isnull(d.execution_count, 0) as ExecCount, p.create_date as CreateDate, p.modify_date as ModifyDate
FROM sys.procedures p left outer join sys.dm_exec_procedure_stats AS d on d.object_id = p.object_id
WHERE is_ms_shipped = 0
ORDER BY create_date asc;