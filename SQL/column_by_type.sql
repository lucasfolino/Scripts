SELECT table_catalog [Database Name],table_name [Table Name], column_name [Column Name]
FROM information_schema.columns where data_type = 'text'