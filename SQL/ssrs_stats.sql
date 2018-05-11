--https://stackoverflow.com/questions/1179082/tracking-report-usage#12601607
SELECT COUNT(Name) AS ExecutionCount,
       Name,
       SUM(TimeDataRetrieval) AS TimeDataRetrievalSum,
       SUM(TimeProcessing) AS TimeProcessingSum,
       SUM(TimeRendering) AS TimeRenderingSum,
       SUM(ByteCount) AS ByteCountSum,
       SUM([RowCount]) AS RowCountSum
  FROM (SELECT TimeStart,
               Catalog.Type,
               Catalog.Name,
               TimeDataRetrieval,
               TimeProcessing,
               TimeRendering,
               ByteCount,
               [RowCount]
          FROM Catalog
               INNER JOIN 
               ExecutionLog
                 ON Catalog.ItemID = ExecutionLog.ReportID
         WHERE Type = 2
       ) AS RE
GROUP BY Name
ORDER BY COUNT(Name) DESC,
         Name;