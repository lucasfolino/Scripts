--https://stackoverflow.com/questions/10767676/currently-running-queries-in-sql-server#10767712

SELECT SPID = er.session_id,
       STATUS = ses.STATUS,
       [Login] = ses.login_name,
       Host = ses.host_name,
       BlkBy = er.blocking_session_id,
       DBName = DB_NAME(er.database_id),
       CommandType = er.command,
       ObjectName = OBJECT_NAME(st.objectid),
       CPUTime = er.cpu_time,
       StartTime = er.start_time,
       TimeElapsed = CAST(GETDATE() - er.start_time AS TIME),
       SQLStatement = st.text
FROM sys.dm_exec_requests er
     OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) st
     LEFT JOIN sys.dm_exec_sessions ses ON ses.session_id = er.session_id
     LEFT JOIN sys.dm_exec_connections con ON con.session_id = ses.session_id
WHERE st.text IS NOT NULL;