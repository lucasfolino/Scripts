SELECT CAST(CAST(st.target_data AS xml).query('RingBufferTarget/event[@name="xml_deadlock_report"]/data/value/text()').value('.', 'nvarchar(MAX)') AS xml)
FROM sys.dm_xe_session_targets st
    INNER JOIN sys.dm_xe_sessions s 
        ON st.event_session_address = s.address
WHERE s.name = 'system_health' AND st.target_name = 'ring_buffer'
FOR XML PATH('deadlock-list');

--per deadlock

SELECT
  xed.value('@timestamp', 'datetime') as Creation_Date,
  xed.query('.') AS Extend_Event
FROM
(
  SELECT CAST([target_data] AS XML) AS Target_Data
  FROM sys.dm_xe_session_targets AS xt
  INNER JOIN sys.dm_xe_sessions AS xs
  ON xs.address = xt.event_session_address
  WHERE xs.name = N'system_health'
  AND xt.target_name = N'ring_buffer'
) AS XML_Data
CROSS APPLY Target_Data.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData(xed)
ORDER BY Creation_Date DESC