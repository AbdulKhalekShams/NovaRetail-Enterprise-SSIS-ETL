:setvar DataPath "C:\NovaRetail_SourcePack\05_HR_SQL\data"
USE NovaRetail_HR;
GO
DELETE FROM dbo.Employees; DELETE FROM dbo.Departments;
DECLARE @BasePath NVARCHAR(4000)=N'$(DataPath)', @sql NVARCHAR(MAX);
SET @sql=N'BULK INSERT dbo.Departments FROM '''+REPLACE(@BasePath,'''','''''')+N'\Departments.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'');'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Employees FROM '''+REPLACE(@BasePath,'''','''''')+N'\Employees.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'');'; EXEC sys.sp_executesql @sql;
GO
