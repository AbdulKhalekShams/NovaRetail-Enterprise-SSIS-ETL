# SSIS Project Files

Copy your existing Visual Studio SSIS solution/project into this folder.

Recommended structure:

```text
ssis/
└── NovaRetail_BI_Platform/
    ├── NovaRetail_BI_Platform.sln
    └── NovaRetail_ETL/
        ├── NovaRetail_ETL.dtproj
        ├── 10_Load_POS_Customers_Staging.dtsx
        ├── 11_Load_POS_Products_Staging.dtsx
        ├── 12_Load_POS_Stores_Staging.dtsx
        ├── 13_Load_POS_Orders_Staging.dtsx
        └── 14_Load_POS_OrderItems_Staging.dtsx
```

Before publishing, verify that no passwords or sensitive local configuration are embedded in connection managers.
