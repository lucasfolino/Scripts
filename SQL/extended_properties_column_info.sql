--https://www.sqlchick.com/entries/2010/11/5/querying-extended-properties-on-sql-server-columns.html
SELECT SysTbls.name AS [Table Name],
       SysCols.name AS [Column Name],
       ExtProp.value AS [Extended Property],
       Systyp.name AS [Data Type],
       CASE
           WHEN Systyp.name IN('nvarchar', 'nchar')
           THEN(SysCols.max_length / 2)
           WHEN Systyp.name IN('char')
           THEN SysCols.max_length
           ELSE NULL
       END AS 'Length of Column',
       CASE
           WHEN SysCols.is_nullable = 0
           THEN 'No'
           WHEN SysCols.is_nullable = 1
           THEN 'Yes'
           ELSE NULL
       END AS 'Column is Nullable',
       SysObj.create_date AS [Table Create Date],
       SysObj.modify_date AS [Table Modify Date]
FROM sys.tables AS SysTbls
     LEFT JOIN sys.extended_properties AS ExtProp ON ExtProp.major_id = SysTbls.[object_id]
     LEFT JOIN sys.columns AS SysCols ON ExtProp.major_id = SysCols.[object_id]
                                         AND ExtProp.minor_id = SysCols.column_id
     LEFT JOIN sys.objects AS SysObj ON SysTbls.[object_id] = SysObj.[object_id]
     INNER JOIN sys.types AS SysTyp ON SysCols.user_type_id = SysTyp.user_type_id
WHERE class = 1 --Object or column

      AND SysTbls.name IS NOT NULL
      AND SysCols.name IS NOT NULL;