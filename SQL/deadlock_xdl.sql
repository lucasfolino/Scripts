SELECT CAST(CAST(st.target_data AS xml).query('RingBufferTarget/event[@name="xml_deadlock_report"]/data/value/text()').value('.', 'nvarchar(MAX)') AS xml)
FROM sys.dm_xe_session_targets st
    INNER JOIN sys.dm_xe_sessions s 
        ON st.event_session_address = s.address
WHERE s.name = 'system_health' AND st.target_name = 'ring_buffer'
FOR XML PATH('deadlock-list');