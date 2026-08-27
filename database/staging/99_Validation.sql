USE NovaRetail_Staging;
GO

SELECT 'Customers' AS Entity, COUNT(*) AS RowsCount FROM dbo.stg_Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM dbo.stg_Products
UNION ALL
SELECT 'Stores', COUNT(*) FROM dbo.stg_Stores
UNION ALL
SELECT 'Orders', COUNT(*) FROM dbo.stg_Orders
UNION ALL
SELECT 'OrderItems', COUNT(*) FROM dbo.stg_OrderItems;
GO

SELECT COUNT(*) AS OrphanOrderItems
FROM dbo.stg_OrderItems oi
LEFT JOIN dbo.stg_Orders o ON oi.OrderID = o.OrderID
WHERE o.OrderID IS NULL;
GO

SELECT COUNT(*) AS UnknownProducts
FROM dbo.stg_OrderItems oi
LEFT JOIN dbo.stg_Products p ON oi.ProductID = p.ProductID
WHERE p.ProductID IS NULL;
GO

SELECT TOP 20 * FROM dbo.ETL_Batch ORDER BY BatchID DESC;
GO
SELECT TOP 20 * FROM dbo.ETL_Error_Log ORDER BY ErrorLogID DESC;
GO
