USE NovaRetail_DWH;
GO


/* Unknown Date */
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.DimDate
    WHERE DateKey = -1
)
BEGIN
    INSERT INTO dbo.DimDate
    (
        DateKey,
        FullDate,
        DayNumber,
        DayName,
        DayOfWeek,
        WeekNumber,
        MonthNumber,
        MonthName,
        YearMonth,
        QuarterNumber,
        QuarterName,
        YearNumber,
        IsWeekend
    )
    VALUES
    (
        -1,
        '1900-01-01',
        0,
        'Unknown',
        0,
        0,
        0,
        'Unknown',
        '0000-00',
        0,
        'Q0',
        0,
        0
    );
END;
GO


/* Unknown Product */
SET IDENTITY_INSERT dbo.DimProduct ON;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.DimProduct
    WHERE ProductKey = -1
)
BEGIN
    INSERT INTO dbo.DimProduct
    (
        ProductKey,
        ProductID,
        ProductName,
        Brand,
        Category,
        Subcategory,
        ProductStatus,
        EffectiveFrom,
        EffectiveTo,
        IsCurrent,
        CreatedAt
    )
    VALUES
    (
        -1,
        'UNKNOWN',
        'Unknown Product',
        'Unknown',
        'Unknown',
        'Unknown',
        'Unknown',
        '1900-01-01',
        '9999-12-31',
        1,
        GETDATE()
    );
END;

SET IDENTITY_INSERT dbo.DimProduct OFF;
GO


/* Unknown Customer */
SET IDENTITY_INSERT dbo.DimCustomer ON;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.DimCustomer
    WHERE CustomerKey = -1
)
BEGIN
    INSERT INTO dbo.DimCustomer
    (
        CustomerKey,
        CustomerID,
        FirstName,
        LastName,
        CustomerStatus,
        EffectiveFrom,
        EffectiveTo,
        IsCurrent,
        CreatedAt
    )
    VALUES
    (
        -1,
        'UNKNOWN',
        'Unknown',
        'Customer',
        'Unknown',
        '1900-01-01',
        '9999-12-31',
        1,
        GETDATE()
    );
END;

SET IDENTITY_INSERT dbo.DimCustomer OFF;
GO


/* Unknown Store */
SET IDENTITY_INSERT dbo.DimStore ON;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.DimStore
    WHERE StoreKey = -1
)
BEGIN
    INSERT INTO dbo.DimStore
    (
        StoreKey,
        StoreID,
        StoreName,
        StoreStatus,
        EffectiveFrom,
        EffectiveTo,
        IsCurrent,
        CreatedAt
    )
    VALUES
    (
        -1,
        'UNKNOWN',
        'Unknown Store',
        'Unknown',
        '1900-01-01',
        '9999-12-31',
        1,
        GETDATE()
    );
END;

SET IDENTITY_INSERT dbo.DimStore OFF;
GO





SET IDENTITY_INSERT dbo.DimSalesChannel ON;

INSERT INTO dbo.DimSalesChannel
(
    SalesChannelKey,
    ChannelCode,
    ChannelName
)
VALUES
(-1, 'UNKNOWN', 'Unknown'),
(1, 'POS', 'Physical Store'),
(2, 'ECOM', 'E-Commerce');

SET IDENTITY_INSERT dbo.DimSalesChannel OFF;
GO












