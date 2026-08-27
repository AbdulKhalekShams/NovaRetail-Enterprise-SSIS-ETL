# NovaRetail Enterprise SSIS ETL

An end-to-end retail data engineering and BI portfolio project built with **SQL Server, SSIS, Data Warehousing, and Power BI**.

## Project Status

**In Development — Phase 1 completed: POS Source → Auditable Staging Layer**

Current completed scope:
- POS source integration
- Transient staging architecture
- Batch-level ETL auditing
- Centralized error logging
- Success / failure execution paths
- Row-count reconciliation
- ETL metadata enrichment
- Product source flattening
- Reusable SSIS package pattern
- Full-load staging for Customers, Products, Stores, Orders, and OrderItems

## Current Architecture

```text
NovaRetail_POS
      |
      v
NovaRetail_Staging
      |
      +-- stg_Customers
      +-- stg_Products
      +-- stg_Stores
      +-- stg_Orders
      +-- stg_OrderItems
      |
      +-- ETL_Batch
      +-- ETL_Error_Log

Next:
NovaRetail_Staging
      |
      v
NovaRetail_DWH
      |
      +-- DimDate
      +-- DimProduct
      +-- DimCustomer
      +-- DimStore
      +-- DimSalesChannel
      +-- FactSales
```

## Current Row Counts

| Entity | Rows |
|---|---:|
| Customers | 20,000 |
| Products | 320 |
| Stores | 12 |
| Orders | 50,000 |
| OrderItems | 150,000 |

## SSIS Packages

```text
10_Load_POS_Customers_Staging.dtsx
11_Load_POS_Products_Staging.dtsx
12_Load_POS_Stores_Staging.dtsx
13_Load_POS_Orders_Staging.dtsx
14_Load_POS_OrderItems_Staging.dtsx
```

Each package follows the same operational pattern:

```text
Start Batch
   ↓
Process Sequence
   ↓
Clear Staging
   ↓
Extract
   ↓
Add ETL Metadata
   ↓
Count Rows
   ↓
Fast Load
   ↓
Success / Failure
   ↓
Audit / Error Logging
```

## Key ETL Concepts Implemented

- OLTP vs Staging
- Full Load
- Transient Staging
- Batch Lineage
- Audit Framework
- Event Handlers
- Error Logging
- Sequence Containers
- Precedence Constraints
- OLE DB Source / Destination
- Fast Load
- Derived Column
- Row Count
- Source-to-Target Mapping
- Source Flattening
- SQL Pushdown
- Data Reconciliation
- Atomic Grain

## Important Design Decisions

### Transient Staging
Staging tables are truncated before each load and contain only the current batch.

### Product Flattening
Product master data is normalized in the POS source and flattened during extraction using SQL joins.

### Auditability
Every ETL execution receives a `BatchID` and records status, start/end time, and row counts.

### Error Handling
SSIS `OnError` event handlers write runtime error details into `ETL_Error_Log`.

## Next Phase

- Create `NovaRetail_DWH`
- Add Unknown Members
- Build `DimDate`
- Implement SCD Type 1 / Type 2
- Resolve Surrogate Keys
- Load `FactSales`
- Add staging-to-DWH reconciliation
- Convert selected full loads to incremental loads
- Implement CDC
- Deploy to SSISDB and schedule execution

## Repository Structure

```text
.
├── README.md
├── .gitignore
├── CHANGELOG.md
├── docs/
├── database/
│   ├── source/
│   ├── staging/
│   └── dwh/
├── ssis/
└── data/sample/
```

## Setup

1. Create or restore the `NovaRetail_POS` source database.
2. Create `NovaRetail_Staging`.
3. Run staging and audit SQL scripts from `database/staging`.
4. Open the SSIS solution in Visual Studio.
5. Update local connection managers if required.
6. Run packages in sequence from `10` to `14`.
7. Validate row counts and audit records.

## Security

Do not publish passwords, secrets, private connection strings, database backups, or company data. The portfolio dataset should remain synthetic.

## Roadmap

- [x] Source system
- [x] Staging layer
- [x] Batch audit
- [x] Error logging
- [x] POS staging packages
- [ ] Dimensional warehouse
- [ ] SCD Type 1 / 2
- [ ] FactSales
- [ ] Incremental loads
- [ ] CDC
- [ ] SSISDB deployment
- [ ] SQL Server Agent scheduling
- [ ] Power BI semantic model
- [ ] Final documentation
