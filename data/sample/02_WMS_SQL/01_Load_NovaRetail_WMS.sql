:setvar DataPath "C:\NovaRetail_SourcePack\02_WMS_SQL\data"
USE NovaRetail_WMS;
GO
DELETE FROM dbo.StockMovements; DELETE FROM dbo.Inventory; DELETE FROM dbo.Warehouses;
DECLARE @BasePath NVARCHAR(4000)=N'$(DataPath)', @sql NVARCHAR(MAX);
SET @sql=N'BULK INSERT dbo.Warehouses FROM '''+REPLACE(@BasePath,'''','''''')+N'\Warehouses.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Inventory FROM '''+REPLACE(@BasePath,'''','''''')+N'\Inventory.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.StockMovements FROM '''+REPLACE(@BasePath,'''','''''')+N'\StockMovements.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
GO
