
SELECT COUNT(*) AS DateRows
FROM NovaRetail_DWH.dbo.DimDate;




SELECT TOP 10 *
FROM NovaRetail_DWH.dbo.DimDate
ORDER BY DateKey;




SELECT MAX(FullDate)
FROM NovaRetail_DWH.dbo.DimDate;




USE NovaRetail_DWH;
GO

ALTER TABLE dbo.DimProduct
ADD CONSTRAINT DF_DimProduct_EffectiveFrom
DEFAULT (SYSDATETIME()) FOR EffectiveFrom;
GO

ALTER TABLE dbo.DimProduct
ADD CONSTRAINT DF_DimProduct_EffectiveTo
DEFAULT ('9999-12-31') FOR EffectiveTo;
GO

ALTER TABLE dbo.DimProduct
ADD CONSTRAINT DF_DimProduct_IsCurrent
DEFAULT (1) FOR IsCurrent;
GO

ALTER TABLE dbo.DimProduct
ADD CONSTRAINT DF_DimProduct_CreatedAt
DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO





CREATE UNIQUE INDEX UX_DimProduct_Current
ON dbo.DimProduct(ProductID)
WHERE IsCurrent = 1;
GO




SELECT COUNT(*) AS TotalRows
FROM NovaRetail_DWH.dbo.DimProduct;




SELECT
    COUNT(*) AS CurrentProducts
FROM NovaRetail_DWH.dbo.DimProduct
WHERE IsCurrent = 1;




SELECT TOP 1
    ProductID,
    ProductName,
    ProductStatus
FROM NovaRetail_Staging.dbo.stg_Products
ORDER BY ProductID;




SELECT
    ProductKey,
    ProductID,
    ProductName,
    ProductStatus,
    EffectiveFrom,
    EffectiveTo,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimProduct
WHERE ProductID = 'P0001';



UPDATE NovaRetail_Staging.dbo.stg_Products
SET ProductName = ProductName + ' - Updated'
WHERE ProductID = 'P0001';





SELECT
    ProductKey,
    ProductID,
    ProductName,
    EffectiveFrom,
    EffectiveTo,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimProduct
WHERE ProductID = 'P0001';


SELECT COUNT(*)
FROM NovaRetail_DWH.dbo.DimProduct;




UPDATE NovaRetail_Staging.dbo.stg_Products
SET ProductStatus = 'Discontinued'
WHERE ProductID = 'P0001';



SELECT
    ProductKey,
    ProductID,
    ProductName,
    ProductStatus,
    EffectiveFrom,
    EffectiveTo,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimProduct
WHERE ProductID = 'P0001'
ORDER BY ProductKey;






USE NovaRetail_DWH;
GO

ALTER TABLE dbo.DimCustomer
ADD CONSTRAINT DF_DimCustomer_EffectiveFrom
DEFAULT (SYSDATETIME()) FOR EffectiveFrom;
GO

ALTER TABLE dbo.DimCustomer
ADD CONSTRAINT DF_DimCustomer_EffectiveTo
DEFAULT ('9999-12-31') FOR EffectiveTo;
GO

ALTER TABLE dbo.DimCustomer
ADD CONSTRAINT DF_DimCustomer_IsCurrent
DEFAULT (1) FOR IsCurrent;
GO

ALTER TABLE dbo.DimCustomer
ADD CONSTRAINT DF_DimCustomer_CreatedAt
DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

CREATE UNIQUE INDEX UX_DimCustomer_Current
ON dbo.DimCustomer(CustomerID)
WHERE IsCurrent = 1;
GO




SELECT COUNT(*)
FROM NovaRetail_DWH.dbo.DimCustomer;


SELECT TOP 1 CustomerID, Email
FROM NovaRetail_Staging.dbo.stg_Customers
ORDER BY CustomerID;




UPDATE NovaRetail_Staging.dbo.stg_Customers
SET Email = 'updated.customer@novaretail.test'
WHERE CustomerID = 'C017273';






SELECT
    CustomerKey,
    CustomerID,
    Email,
    City,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimCustomer
WHERE CustomerID = 'C017273';





USE NovaRetail_DWH;
GO

ALTER TABLE dbo.DimStore
ADD CONSTRAINT DF_DimStore_EffectiveFrom
DEFAULT (SYSDATETIME()) FOR EffectiveFrom;
GO

ALTER TABLE dbo.DimStore
ADD CONSTRAINT DF_DimStore_EffectiveTo
DEFAULT ('9999-12-31') FOR EffectiveTo;
GO

ALTER TABLE dbo.DimStore
ADD CONSTRAINT DF_DimStore_IsCurrent
DEFAULT (1) FOR IsCurrent;
GO

ALTER TABLE dbo.DimStore
ADD CONSTRAINT DF_DimStore_CreatedAt
DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO

CREATE UNIQUE INDEX UX_DimStore_Current
ON dbo.DimStore(StoreID)
WHERE IsCurrent = 1;
GO







SELECT COUNT(*)
FROM NovaRetail_DWH.dbo.DimStore;





SELECT COUNT(*) AS TotalStores
FROM NovaRetail_DWH.dbo.DimStore;




SELECT TOP 1
    StoreID,
    StoreName
FROM NovaRetail_Staging.dbo.stg_Stores
ORDER BY StoreID;





UPDATE NovaRetail_Staging.dbo.stg_Stores
SET StoreName = StoreName + N' - Updated'
WHERE StoreID = 'S001';



SELECT
    StoreKey,
    StoreID,
    StoreName,
    City,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimStore
WHERE StoreID = 'S001';



UPDATE NovaRetail_Staging.dbo.stg_Stores
SET StoreStatus = 'Temporarily Closed'
WHERE StoreID = 'S001';





SELECT
    StoreKey,
    StoreID,
    StoreName,
    StoreStatus,
    EffectiveFrom,
    EffectiveTo,
    IsCurrent
FROM NovaRetail_DWH.dbo.DimStore
WHERE StoreID = 'S001'
ORDER BY StoreKey;






USE NovaRetail_DWH;
GO

SELECT *
FROM dbo.DimSalesChannel;




USE NovaRetail_DWH;
GO




/* Product - oldest version */
;WITH X AS
(
    SELECT
        ProductKey,
        ROW_NUMBER() OVER
        (
            PARTITION BY ProductID
            ORDER BY EffectiveFrom, ProductKey
        ) AS RN
    FROM dbo.DimProduct
    WHERE ProductKey <> -1
)
UPDATE P
SET EffectiveFrom = '1900-01-01'
FROM dbo.DimProduct P
INNER JOIN X
    ON P.ProductKey = X.ProductKey
WHERE X.RN = 1;
GO


/* Customer - oldest version */
;WITH X AS
(
    SELECT
        CustomerKey,
        ROW_NUMBER() OVER
        (
            PARTITION BY CustomerID
            ORDER BY EffectiveFrom, CustomerKey
        ) AS RN
    FROM dbo.DimCustomer
    WHERE CustomerKey <> -1
)
UPDATE C
SET EffectiveFrom = '1900-01-01'
FROM dbo.DimCustomer C
INNER JOIN X
    ON C.CustomerKey = X.CustomerKey
WHERE X.RN = 1;
GO


/* Store - oldest version */
;WITH X AS
(
    SELECT
        StoreKey,
        ROW_NUMBER() OVER
        (
            PARTITION BY StoreID
            ORDER BY EffectiveFrom, StoreKey
        ) AS RN
    FROM dbo.DimStore
    WHERE StoreKey <> -1
)
UPDATE S
SET EffectiveFrom = '1900-01-01'
FROM dbo.DimStore S
INNER JOIN X
    ON S.StoreKey = X.StoreKey
WHERE X.RN = 1;
GO







USE NovaRetail_DWH;
GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT DF_FactSales_CreatedAt
DEFAULT (SYSDATETIME()) FOR CreatedAt;
GO


CREATE UNIQUE INDEX UX_FactSales_Channel_OrderLine
ON dbo.FactSales
(
    SalesChannelKey,
    OrderLineID
);
GO







SELECT OrderStatus, COUNT(*)
FROM dbo.stg_Orders
GROUP BY OrderStatus;





SELECT COUNT(*) AS ExpectedFactRows
FROM NovaRetail_Staging.dbo.stg_OrderItems oi
INNER JOIN NovaRetail_Staging.dbo.stg_Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed';





SELECT COUNT(*) AS ActualFactRows
FROM NovaRetail_DWH.dbo.FactSales;







SELECT
    SUM(CASE WHEN ProductKey = -1 THEN 1 ELSE 0 END) AS UnknownProductRows,
    SUM(CASE WHEN CustomerKey = -1 THEN 1 ELSE 0 END) AS UnknownCustomerRows,
    SUM(CASE WHEN StoreKey = -1 THEN 1 ELSE 0 END) AS UnknownStoreRows
FROM NovaRetail_DWH.dbo.FactSales;





SELECT COUNT(*) AS ExpectedUnknownCustomers
FROM NovaRetail_Staging.dbo.stg_OrderItems oi
INNER JOIN NovaRetail_Staging.dbo.stg_Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'
  AND o.CustomerID IS NULL;



SELECT
    SUM(CAST(oi.Quantity * oi.UnitPrice AS DECIMAL(18,2)))
        AS ExpectedGrossSales,

    SUM(oi.DiscountAmount)
        AS ExpectedDiscount,

    SUM(
        CAST(
            (oi.Quantity * oi.UnitPrice)
            - oi.DiscountAmount
            AS DECIMAL(18,2)
        )
    ) AS ExpectedNetSales,

    SUM(
        CAST(
            oi.Quantity * oi.UnitCostAtSale
            AS DECIMAL(18,2)
        )
    ) AS ExpectedCost,

    SUM(
        CAST(
            ((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount)
            - (oi.Quantity * oi.UnitCostAtSale)
            AS DECIMAL(18,2)
        )
    ) AS ExpectedProfit

FROM NovaRetail_Staging.dbo.stg_OrderItems oi
INNER JOIN NovaRetail_Staging.dbo.stg_Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed';






ExpectedGrossSales	ExpectedDiscount	ExpectedNetSales	ExpectedCost	ExpectedProfit
3794583799.22	129977509.72	3664606289.50	2988399713.74	676206575.76






SELECT
    SUM(GrossSalesAmount) AS ActualGrossSales,
    SUM(DiscountAmount)   AS ActualDiscount,
    SUM(NetSalesAmount)   AS ActualNetSales,
    SUM(TotalCostAmount)  AS ActualCost,
    SUM(ProfitAmount)     AS ActualProfit
FROM NovaRetail_DWH.dbo.FactSales;








SELECT
    COUNT(*) AS TotalFactRows,
    COUNT(DISTINCT OrderLineID) AS DistinctOrderLines
FROM NovaRetail_DWH.dbo.FactSales;





SELECT COUNT(*)
FROM NovaRetail_DWH.dbo.FactSales;


















