USE master;
GO
IF DB_ID(N'NovaRetail_WMS') IS NULL CREATE DATABASE NovaRetail_WMS;
GO
USE NovaRetail_WMS;
GO
DROP TABLE IF EXISTS dbo.StockMovements;
DROP TABLE IF EXISTS dbo.Inventory;
DROP TABLE IF EXISTS dbo.Warehouses;
GO
CREATE TABLE dbo.Warehouses(
 WarehouseID VARCHAR(10) PRIMARY KEY, WarehouseName NVARCHAR(150) NOT NULL,
 City NVARCHAR(80) NOT NULL, Region NVARCHAR(80) NOT NULL, WarehouseStatus VARCHAR(30) NOT NULL,
 CreatedAt DATETIME2(0) NOT NULL, ModifiedAt DATETIME2(0) NOT NULL
);
CREATE TABLE dbo.Inventory(
 WarehouseID VARCHAR(10) NOT NULL, ProductID VARCHAR(10) NOT NULL,
 QuantityOnHand INT NOT NULL, ReservedQuantity INT NOT NULL, AvailableQuantity INT NOT NULL,
 LastUpdated DATETIME2(0) NOT NULL,
 CONSTRAINT PK_Inventory PRIMARY KEY(WarehouseID,ProductID),
 CONSTRAINT FK_Inventory_Warehouse FOREIGN KEY(WarehouseID) REFERENCES dbo.Warehouses(WarehouseID)
);
CREATE TABLE dbo.StockMovements(
 MovementID BIGINT PRIMARY KEY, WarehouseID VARCHAR(10) NOT NULL, ProductID VARCHAR(10) NOT NULL,
 MovementType VARCHAR(30) NOT NULL, QuantityChange INT NOT NULL, MovementDateTime DATETIME2(0) NOT NULL,
 ReferenceNo VARCHAR(30) NULL, CreatedAt DATETIME2(0) NOT NULL,
 CONSTRAINT FK_StockMovements_Warehouse FOREIGN KEY(WarehouseID) REFERENCES dbo.Warehouses(WarehouseID)
);
CREATE INDEX IX_StockMovements_Date ON dbo.StockMovements(MovementDateTime);
CREATE INDEX IX_StockMovements_Product ON dbo.StockMovements(ProductID);
GO
