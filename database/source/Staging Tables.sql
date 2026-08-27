-- Source Count
SELECT COUNT(*) AS SourceCount
FROM NovaRetail_POS.dbo.Customers;

-- Staging Count
SELECT COUNT(*) AS StagingCount
FROM NovaRetail_Staging.dbo.stg_Customers;



SELECT
    BatchID,
    SourceSystem,
    COUNT(*) AS RowCounnt,
    MIN(ExtractedAt) AS FirstExtractedAt,
    MAX(ExtractedAt) AS LastExtractedAt
FROM NovaRetail_Staging.dbo.stg_Customers
GROUP BY
    BatchID,
    SourceSystem;







CREATE TABLE dbo.ETL_Batch
(
    BatchID         BIGINT IDENTITY(1,1) PRIMARY KEY,
    PackageName     VARCHAR(150) NOT NULL,
    SourceSystem    VARCHAR(50) NULL,
    StartTime       DATETIME2(0) NOT NULL,
    EndTime         DATETIME2(0) NULL,
    Status          VARCHAR(20) NOT NULL,
    ExtractedRows   BIGINT NULL,
    LoadedRows      BIGINT NULL,
    RejectedRows    BIGINT NULL,
    ErrorMessage    NVARCHAR(2000) NULL
);







SELECT *
FROM NovaRetail_Staging.dbo.ETL_Batch
ORDER BY BatchID DESC;




SELECT
    BatchID,
    SourceSystem,
    COUNT(*) AS RowsLoaded
FROM NovaRetail_Staging.dbo.stg_Customers
GROUP BY BatchID, SourceSystem;








SELECT
    BatchID,
    PackageName,
    SourceSystem,
    StartTime,
    EndTime,
    Status,
    ExtractedRows,
    LoadedRows,
    RejectedRows
FROM NovaRetail_Staging.dbo.ETL_Batch
ORDER BY BatchID DESC;



CREATE TABLE dbo.ETL_Error_Log
(
    ErrorLogID        BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchID           BIGINT NULL,
    PackageName       VARCHAR(150) NULL,
    SourceName        VARCHAR(200) NULL,
    ErrorCode         INT NULL,
    ErrorDescription  NVARCHAR(4000) NULL,
    ErrorTime         DATETIME2(0) NOT NULL
);








SELECT TOP 5 *
FROM NovaRetail_Staging.dbo.ETL_Batch
ORDER BY BatchID DESC;




SELECT TOP 10 *
FROM NovaRetail_Staging.dbo.ETL_Error_Log
ORDER BY ErrorLogID DESC;




CREATE TABLE dbo.stg_Products
(
    ProductID          VARCHAR(10)     NULL,
    ProductName        NVARCHAR(200)   NULL,
    Brand              NVARCHAR(100)   NULL,
    Category           NVARCHAR(100)   NULL,
    Subcategory        NVARCHAR(100)   NULL,
    Model              NVARCHAR(100)   NULL,
    Color              NVARCHAR(50)    NULL,
    LaunchDate         DATE            NULL,
    ProductStatus      VARCHAR(30)     NULL,
    StandardCost       DECIMAL(18,2)   NULL,
    ListPrice          DECIMAL(18,2)   NULL,
    IsDeleted          BIT             NULL,
    ModifiedAt         DATETIME2(0)    NULL,

    BatchID            BIGINT          NOT NULL,
    ExtractedAt        DATETIME2(0)    NOT NULL,
    SourceSystem       VARCHAR(30)     NOT NULL
);
GO

CREATE TABLE dbo.stg_Stores
(
    StoreID            VARCHAR(10)     NULL,
    StoreName          NVARCHAR(150)   NULL,
    StoreType          VARCHAR(30)     NULL,
    City               NVARCHAR(80)    NULL,
    Region             NVARCHAR(80)    NULL,
    OpeningDate        DATE            NULL,
    StoreStatus        VARCHAR(30)     NULL,
    FloorAreaSqm       INT             NULL,
    ModifiedAt         DATETIME2(0)    NULL,

    BatchID            BIGINT          NOT NULL,
    ExtractedAt        DATETIME2(0)    NOT NULL,
    SourceSystem       VARCHAR(30)     NOT NULL
);
GO

CREATE TABLE dbo.stg_Orders
(
    OrderID             VARCHAR(15)    NULL,
    CustomerID          VARCHAR(10)    NULL,
    StoreID             VARCHAR(10)    NULL,
    OrderDateTime       DATETIME2(0)   NULL,
    OrderStatus         VARCHAR(30)    NULL,
    PaymentMethodCode   VARCHAR(30)    NULL,
    OrderTotalAmount    DECIMAL(18,2)  NULL,
    ModifiedAt          DATETIME2(0)   NULL,

    BatchID             BIGINT         NOT NULL,
    ExtractedAt         DATETIME2(0)   NOT NULL,
    SourceSystem        VARCHAR(30)    NOT NULL
);
GO

CREATE TABLE dbo.stg_OrderItems
(
    OrderLineID         BIGINT         NULL,
    OrderID             VARCHAR(15)    NULL,
    ProductID           VARCHAR(10)    NULL,
    Quantity            INT            NULL,
    UnitPrice           DECIMAL(18,2)  NULL,
    UnitCostAtSale      DECIMAL(18,2)  NULL,
    DiscountAmount      DECIMAL(18,2)  NULL,
    ModifiedAt          DATETIME2(0)   NULL,

    BatchID             BIGINT         NOT NULL,
    ExtractedAt         DATETIME2(0)   NOT NULL,
    SourceSystem        VARCHAR(30)     NOT NULL
);
GO








SELECT COUNT(*) AS ProductsCount
FROM NovaRetail_Staging.dbo.stg_Products;






SELECT TOP 10
    ProductID,
    ProductName,
    Brand,
    Category,
    Subcategory,
    BatchID,
    SourceSystem
FROM NovaRetail_Staging.dbo.stg_Products;



SELECT
    COUNT(*) AS TotalProducts,
    SUM(CASE WHEN Brand IS NULL THEN 1 ELSE 0 END) AS MissingBrand,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS MissingCategory,
    SUM(CASE WHEN Subcategory IS NULL THEN 1 ELSE 0 END) AS MissingSubcategory
FROM NovaRetail_Staging.dbo.stg_Products;




SELECT COUNT(*)
FROM NovaRetail_Staging.dbo.stg_Stores;






SELECT COUNT(*)
FROM NovaRetail_Staging.dbo.stg_Orders;



SELECT
    OrderStatus,
    COUNT(*) AS OrdersCount
FROM NovaRetail_Staging.dbo.stg_Orders
GROUP BY OrderStatus;


SELECT
    'Customers' AS Entity,
    COUNT(*) AS RowsCount
FROM dbo.stg_Customers

UNION ALL

SELECT
    'Products',
    COUNT(*)
FROM dbo.stg_Products

UNION ALL

SELECT
    'Stores',
    COUNT(*)
FROM dbo.stg_Stores

UNION ALL

SELECT
    'Orders',
    COUNT(*)
FROM dbo.stg_Orders

UNION ALL

SELECT
    'OrderItems',
    COUNT(*)
FROM dbo.stg_OrderItems;

------------------------------------------------------------


SELECT COUNT(*) AS OrphanOrderItems
FROM dbo.stg_OrderItems oi
LEFT JOIN dbo.stg_Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderID IS NULL;







SELECT COUNT(*) AS UnknownProducts
FROM dbo.stg_OrderItems oi
LEFT JOIN dbo.stg_Products p
    ON oi.ProductID = p.ProductID
WHERE p.ProductID IS NULL;
























