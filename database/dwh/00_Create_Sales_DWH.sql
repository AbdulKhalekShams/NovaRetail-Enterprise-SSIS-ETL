/*========================================================
  NovaRetail Sales Data Warehouse
========================================================*/

IF DB_ID('NovaRetail_DWH') IS NULL
BEGIN
    CREATE DATABASE NovaRetail_DWH;
END;
GO

USE NovaRetail_DWH;
GO


/*========================================================
  1. DimDate
========================================================*/
CREATE TABLE dbo.DimDate
(
    DateKey         INT            NOT NULL PRIMARY KEY,
    FullDate        DATE           NOT NULL,

    DayNumber       TINYINT        NOT NULL,
    DayName         VARCHAR(20)    NOT NULL,
    DayOfWeek       TINYINT        NOT NULL,

    WeekNumber      TINYINT        NOT NULL,

    MonthNumber     TINYINT        NOT NULL,
    MonthName       VARCHAR(20)    NOT NULL,
    YearMonth       CHAR(7)        NOT NULL,

    QuarterNumber   TINYINT        NOT NULL,
    QuarterName     CHAR(2)        NOT NULL,

    YearNumber      SMALLINT       NOT NULL,

    IsWeekend       BIT            NOT NULL
);
GO


/*========================================================
  2. DimProduct
========================================================*/
CREATE TABLE dbo.DimProduct
(
    ProductKey      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

    ProductID       VARCHAR(10)       NOT NULL, -- Business Key
    ProductName     NVARCHAR(200)     NULL,
    Brand           NVARCHAR(100)     NULL,
    Category        NVARCHAR(100)     NULL,
    Subcategory     NVARCHAR(100)     NULL,
    Model           NVARCHAR(100)     NULL,
    Color           NVARCHAR(50)      NULL,
    LaunchDate      DATE              NULL,
    ProductStatus   VARCHAR(30)       NULL,

    StandardCost    DECIMAL(18,2)     NULL,
    ListPrice       DECIMAL(18,2)     NULL,

    EffectiveFrom   DATETIME2(0)      NOT NULL,
    EffectiveTo     DATETIME2(0)      NOT NULL,
    IsCurrent       BIT               NOT NULL,

    BatchID         BIGINT            NULL,
    CreatedAt       DATETIME2(0)      NOT NULL
);
GO


/*========================================================
  3. DimCustomer
========================================================*/
CREATE TABLE dbo.DimCustomer
(
    CustomerKey        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

    CustomerID         VARCHAR(10)       NOT NULL, -- Business Key
    FirstName          NVARCHAR(80)      NULL,
    LastName           NVARCHAR(80)      NULL,
    Gender             VARCHAR(10)       NULL,
    BirthDate          DATE              NULL,
    Email              NVARCHAR(200)     NULL,
    Phone              VARCHAR(30)       NULL,

    City               NVARCHAR(80)      NULL,
    Region             NVARCHAR(80)      NULL,
    CustomerSegment    VARCHAR(30)       NULL,
    CustomerStatus     VARCHAR(30)       NULL,

    RegistrationDate   DATE              NULL,

    EffectiveFrom      DATETIME2(0)      NOT NULL,
    EffectiveTo        DATETIME2(0)      NOT NULL,
    IsCurrent          BIT               NOT NULL,

    BatchID            BIGINT            NULL,
    CreatedAt          DATETIME2(0)      NOT NULL
);
GO


/*========================================================
  4. DimStore
========================================================*/
CREATE TABLE dbo.DimStore
(
    StoreKey         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

    StoreID          VARCHAR(10)       NOT NULL, -- Business Key
    StoreName        NVARCHAR(150)     NULL,
    StoreType        VARCHAR(30)       NULL,
    City             NVARCHAR(80)      NULL,
    Region           NVARCHAR(80)      NULL,
    OpeningDate      DATE              NULL,
    StoreStatus      VARCHAR(30)       NULL,
    FloorAreaSqm     INT               NULL,

    EffectiveFrom    DATETIME2(0)      NOT NULL,
    EffectiveTo      DATETIME2(0)      NOT NULL,
    IsCurrent        BIT               NOT NULL,

    BatchID          BIGINT            NULL,
    CreatedAt        DATETIME2(0)      NOT NULL
);
GO


/*========================================================
  5. DimSalesChannel
========================================================*/
CREATE TABLE dbo.DimSalesChannel
(
    SalesChannelKey   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ChannelCode       VARCHAR(20)       NOT NULL,
    ChannelName       VARCHAR(50)       NOT NULL
);
GO


/*========================================================
  6. FactSales
========================================================*/
CREATE TABLE dbo.FactSales
(
    SalesKey          BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,

    OrderID           VARCHAR(15)      NOT NULL,
    OrderLineID       BIGINT           NOT NULL,

    DateKey           INT              NOT NULL,
    ProductKey        INT              NOT NULL,
    CustomerKey       INT              NOT NULL,
    StoreKey          INT              NOT NULL,
    SalesChannelKey   INT              NOT NULL,

    OrderDateTime     DATETIME2(0)     NOT NULL,

    Quantity          INT              NOT NULL,
    UnitPrice         DECIMAL(18,2)    NOT NULL,
    UnitCost          DECIMAL(18,2)    NOT NULL,

    GrossSalesAmount  DECIMAL(18,2)    NOT NULL,
    DiscountAmount    DECIMAL(18,2)    NOT NULL,
    NetSalesAmount    DECIMAL(18,2)    NOT NULL,
    TotalCostAmount   DECIMAL(18,2)    NOT NULL,
    ProfitAmount      DECIMAL(18,2)    NOT NULL,

    LoadBatchID       BIGINT           NULL,
    CreatedAt         DATETIME2(0)     NOT NULL
);
GO