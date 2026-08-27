USE master;
GO
IF DB_ID(N'NovaRetail_HR') IS NULL CREATE DATABASE NovaRetail_HR;
GO
USE NovaRetail_HR;
GO
DROP TABLE IF EXISTS dbo.Employees; DROP TABLE IF EXISTS dbo.Departments;
CREATE TABLE dbo.Departments(DepartmentID INT PRIMARY KEY, DepartmentName NVARCHAR(100) NOT NULL);
CREATE TABLE dbo.Employees(
 EmployeeID VARCHAR(10) PRIMARY KEY, FirstName NVARCHAR(80) NOT NULL, LastName NVARCHAR(80) NOT NULL,
 Gender VARCHAR(10) NOT NULL, DepartmentID INT NOT NULL, JobTitle NVARCHAR(120) NOT NULL,
 StoreID VARCHAR(10) NULL, HireDate DATE NOT NULL, EmployeeStatus VARCHAR(30) NOT NULL,
 CONSTRAINT FK_Employees_Departments FOREIGN KEY(DepartmentID) REFERENCES dbo.Departments(DepartmentID)
);
GO
