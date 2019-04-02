--https://www.mssqltips.com/sqlservertip/5384/working-with-sql-server-extended-properties/
SELECT SCHEMA_NAME(tbl.schema_id) AS SchemaName,
       tbl.name AS TableName,
       p.name AS ExtendedPropertyName,
       CAST(p.value AS SQL_VARIANT) AS ExtendedPropertyValue
FROM sys.tables AS tbl
     LEFT JOIN sys.extended_properties AS p ON p.major_id = tbl.object_id
                                               AND p.minor_id = 0
                                               AND p.class = 1
ORDER BY TableName;