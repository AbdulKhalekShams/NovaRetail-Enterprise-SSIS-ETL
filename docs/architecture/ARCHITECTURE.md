# Architecture

```text
                        +------------------+
                        |  NovaRetail_POS  |
                        +--------+---------+
                                 |
                                 | SSIS Full Load
                                 v
                     +------------------------+
                     | NovaRetail_Staging     |
                     +------------------------+
                     | stg_Customers          |
                     | stg_Products           |
                     | stg_Stores             |
                     | stg_Orders             |
                     | stg_OrderItems         |
                     | ETL_Batch              |
                     | ETL_Error_Log          |
                     +-----------+------------+
                                 |
                                 | Next phase
                                 v
                     +------------------------+
                     | NovaRetail_DWH         |
                     +------------------------+
                     | DimDate                |
                     | DimProduct             |
                     | DimCustomer            |
                     | DimStore               |
                     | DimSalesChannel        |
                     | FactSales              |
                     +------------------------+
```
