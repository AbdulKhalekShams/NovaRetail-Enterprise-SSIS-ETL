USE master;
GO
IF DB_ID(N'NovaRetail_POS') IS NULL
    CREATE DATABASE NovaRetail_POS;
GO
USE NovaRetail_POS;
GO

DROP TABLE IF EXISTS dbo.Payments;
DROP TABLE IF EXISTS dbo.OrderItems;
DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Customers;
DROP TABLE IF EXISTS dbo.Stores;
DROP TABLE IF EXISTS dbo.Products;
DROP TABLE IF EXISTS dbo.Subcategories;
DROP TABLE IF EXISTS dbo.Categories;
DROP TABLE IF EXISTS dbo.Brands;
GO

CREATE TABLE dbo.Categories(
    CategoryID       INT            NOT NULL PRIMARY KEY,
    CategoryName     NVARCHAR(100)  NOT NULL,
    CategoryStatus   VARCHAR(20)    NOT NULL,
    CreatedAt        DATETIME2(0)   NOT NULL,
    ModifiedAt       DATETIME2(0)   NOT NULL
);

CREATE TABLE dbo.Subcategories(
    SubcategoryID      INT            NOT NULL PRIMARY KEY,
    CategoryID         INT            NOT NULL,
    SubcategoryName    NVARCHAR(100)  NOT NULL,
    SubcategoryStatus  VARCHAR(20)    NOT NULL,
    CreatedAt          DATETIME2(0)   NOT NULL,
    ModifiedAt         DATETIME2(0)   NOT NULL,
    CONSTRAINT FK_Subcategories_Categories FOREIGN KEY(CategoryID) REFERENCES dbo.Categories(CategoryID)
);

CREATE TABLE dbo.Brands(
    BrandID       INT            NOT NULL PRIMARY KEY,
    BrandName     NVARCHAR(100)  NOT NULL,
    BrandStatus   VARCHAR(20)    NOT NULL,
    CreatedAt     DATETIME2(0)   NOT NULL,
    ModifiedAt    DATETIME2(0)   NOT NULL
);

CREATE TABLE dbo.Products(
    ProductID       VARCHAR(10)    NOT NULL PRIMARY KEY,
    ProductName     NVARCHAR(200)  NOT NULL,
    BrandID         INT            NOT NULL,
    SubcategoryID   INT            NOT NULL,
    Model           NVARCHAR(100)  NULL,
    Color           NVARCHAR(50)   NULL,
    LaunchDate      DATE           NULL,
    ProductStatus   VARCHAR(30)    NOT NULL,
    StandardCost    DECIMAL(18,2)  NOT NULL,
    ListPrice       DECIMAL(18,2)  NOT NULL,
    IsDeleted       BIT            NOT NULL CONSTRAINT DF_Products_IsDeleted DEFAULT(0),
    CreatedAt       DATETIME2(0)   NOT NULL,
    ModifiedAt      DATETIME2(0)   NOT NULL,
    CONSTRAINT CK_Products_Cost CHECK(StandardCost >= 0),
    CONSTRAINT CK_Products_Price CHECK(ListPrice >= 0),
    CONSTRAINT FK_Products_Brands FOREIGN KEY(BrandID) REFERENCES dbo.Brands(BrandID),
    CONSTRAINT FK_Products_Subcategories FOREIGN KEY(SubcategoryID) REFERENCES dbo.Subcategories(SubcategoryID)
);

CREATE TABLE dbo.Stores(
    StoreID        VARCHAR(10)    NOT NULL PRIMARY KEY,
    StoreName      NVARCHAR(150)  NOT NULL,
    StoreType      VARCHAR(30)    NOT NULL,
    City           NVARCHAR(80)   NOT NULL,
    Region         NVARCHAR(80)   NOT NULL,
    OpeningDate    DATE           NOT NULL,
    StoreStatus    VARCHAR(30)    NOT NULL,
    FloorAreaSqm   INT            NOT NULL,
    CreatedAt      DATETIME2(0)   NOT NULL,
    ModifiedAt     DATETIME2(0)   NOT NULL,
    CONSTRAINT CK_Stores_FloorArea CHECK(FloorAreaSqm > 0)
);

CREATE TABLE dbo.Customers(
    CustomerID        VARCHAR(10)    NOT NULL PRIMARY KEY,
    FirstName         NVARCHAR(80)   NOT NULL,
    LastName          NVARCHAR(80)   NOT NULL,
    Gender            VARCHAR(10)    NOT NULL,
    BirthDate         DATE           NULL,
    Email             NVARCHAR(200)  NULL,
    Phone             VARCHAR(30)    NULL,
    City              NVARCHAR(80)   NOT NULL,
    Region            NVARCHAR(80)   NOT NULL,
    CustomerSegment   VARCHAR(30)    NOT NULL,
    CustomerStatus    VARCHAR(30)    NOT NULL,
    RegistrationDate  DATE           NOT NULL,
    CreatedAt         DATETIME2(0)   NOT NULL,
    ModifiedAt        DATETIME2(0)   NOT NULL,
    IsDeleted         BIT            NOT NULL CONSTRAINT DF_Customers_IsDeleted DEFAULT(0)
);

CREATE TABLE dbo.Orders(
    OrderID            VARCHAR(15)    NOT NULL PRIMARY KEY,
    CustomerID         VARCHAR(10)    NULL,
    StoreID            VARCHAR(10)    NOT NULL,
    OrderDateTime      DATETIME2(0)   NOT NULL,
    OrderStatus        VARCHAR(30)    NOT NULL,
    PaymentMethodCode  VARCHAR(30)    NOT NULL,
    OrderTotalAmount   DECIMAL(18,2)  NOT NULL,
    CreatedAt          DATETIME2(0)   NOT NULL,
    ModifiedAt         DATETIME2(0)   NOT NULL,
    CONSTRAINT CK_Orders_Total CHECK(OrderTotalAmount >= 0),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY(CustomerID) REFERENCES dbo.Customers(CustomerID),
    CONSTRAINT FK_Orders_Stores FOREIGN KEY(StoreID) REFERENCES dbo.Stores(StoreID)
);

CREATE TABLE dbo.OrderItems(
    OrderLineID     BIGINT         NOT NULL PRIMARY KEY,
    OrderID         VARCHAR(15)    NOT NULL,
    ProductID       VARCHAR(10)    NOT NULL,
    Quantity        INT            NOT NULL,
    UnitPrice       DECIMAL(18,2)  NOT NULL,
    UnitCostAtSale  DECIMAL(18,2)  NOT NULL,
    DiscountAmount  DECIMAL(18,2)  NOT NULL,
    CreatedAt       DATETIME2(0)   NOT NULL,
    ModifiedAt      DATETIME2(0)   NOT NULL,
    CONSTRAINT CK_OrderItems_Qty CHECK(Quantity > 0),
    CONSTRAINT CK_OrderItems_Price CHECK(UnitPrice >= 0),
    CONSTRAINT CK_OrderItems_Cost CHECK(UnitCostAtSale >= 0),
    CONSTRAINT CK_OrderItems_Discount CHECK(DiscountAmount >= 0),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY(OrderID) REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY(ProductID) REFERENCES dbo.Products(ProductID)
);

CREATE TABLE dbo.Payments(
    PaymentID        BIGINT         NOT NULL PRIMARY KEY,
    OrderID          VARCHAR(15)    NOT NULL,
    PaymentMethod    VARCHAR(30)    NOT NULL,
    PaymentAmount    DECIMAL(18,2)  NOT NULL,
    PaymentStatus    VARCHAR(30)    NOT NULL,
    PaymentDateTime  DATETIME2(0)   NOT NULL,
    CreatedAt        DATETIME2(0)   NOT NULL,
    ModifiedAt       DATETIME2(0)   NOT NULL,
    CONSTRAINT CK_Payments_Amount CHECK(PaymentAmount >= 0),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY(OrderID) REFERENCES dbo.Orders(OrderID)
);
GO

CREATE INDEX IX_Customers_ModifiedAt ON dbo.Customers(ModifiedAt);
CREATE INDEX IX_Products_ModifiedAt ON dbo.Products(ModifiedAt);
CREATE INDEX IX_Orders_OrderDateTime ON dbo.Orders(OrderDateTime);
CREATE INDEX IX_Orders_ModifiedAt ON dbo.Orders(ModifiedAt);
CREATE INDEX IX_OrderItems_OrderID ON dbo.OrderItems(OrderID);
CREATE INDEX IX_OrderItems_ProductID ON dbo.OrderItems(ProductID);
CREATE INDEX IX_OrderItems_ModifiedAt ON dbo.OrderItems(ModifiedAt);
GO
