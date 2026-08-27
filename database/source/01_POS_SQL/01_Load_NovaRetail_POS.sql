:setvar DataPath "D:\Data Engineering Diploma\ETL Project (SSIS)\NovaRetail_SourcePack\NovaRetail_SourcePack\01_POS_SQL\data"
USE NovaRetail_POS;
GO
SET NOCOUNT ON;

DELETE FROM dbo.Payments;
DELETE FROM dbo.OrderItems;
DELETE FROM dbo.Orders;
DELETE FROM dbo.Customers;
DELETE FROM dbo.Stores;
DELETE FROM dbo.Products;
DELETE FROM dbo.Subcategories;
DELETE FROM dbo.Categories;
DELETE FROM dbo.Brands;

DECLARE @BasePath NVARCHAR(4000)=N'$(DataPath)', @sql NVARCHAR(MAX);

SET @sql=N'BULK INSERT dbo.Categories FROM '''+REPLACE(@BasePath,'''','''''')+N'\Categories.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Brands FROM '''+REPLACE(@BasePath,'''','''''')+N'\Brands.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Subcategories FROM '''+REPLACE(@BasePath,'''','''''')+N'\Subcategories.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Products FROM '''+REPLACE(@BasePath,'''','''''')+N'\Products.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Stores FROM '''+REPLACE(@BasePath,'''','''''')+N'\Stores.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Customers FROM '''+REPLACE(@BasePath,'''','''''')+N'\Customers.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;

-- Guest sales have blank CustomerID in the CSV. Disable only this FK during raw load, then convert blanks to NULL.
ALTER TABLE dbo.Orders NOCHECK CONSTRAINT FK_Orders_Customers;
SET @sql=N'BULK INSERT dbo.Orders FROM '''+REPLACE(@BasePath,'''','''''')+N'\Orders.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
UPDATE dbo.Orders SET CustomerID=NULL WHERE LTRIM(RTRIM(ISNULL(CustomerID,'')))='';
ALTER TABLE dbo.Orders WITH CHECK CHECK CONSTRAINT FK_Orders_Customers;

SET @sql=N'BULK INSERT dbo.OrderItems FROM '''+REPLACE(@BasePath,'''','''''')+N'\OrderItems.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;
SET @sql=N'BULK INSERT dbo.Payments FROM '''+REPLACE(@BasePath,'''','''''')+N'\Payments.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', CODEPAGE=''65001'', TABLOCK);'; EXEC sys.sp_executesql @sql;

SELECT 'Customers' TableName, COUNT(*) [RowCount] FROM dbo.Customers
UNION ALL SELECT 'Products',COUNT(*) FROM dbo.Products
UNION ALL SELECT 'Orders',COUNT(*) FROM dbo.Orders
UNION ALL SELECT 'OrderItems',COUNT(*) FROM dbo.OrderItems
UNION ALL SELECT 'Payments',COUNT(*) FROM dbo.Payments;
GO
