USE NovaRetail_Staging;
GO

IF OBJECT_ID('dbo.ETL_Batch','U') IS NULL
BEGIN
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
END;
GO

IF OBJECT_ID('dbo.ETL_Error_Log','U') IS NULL
BEGIN
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
END;
GO
