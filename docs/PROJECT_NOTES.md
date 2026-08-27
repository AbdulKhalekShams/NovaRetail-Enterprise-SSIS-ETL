# Project Notes

## Completed Milestone: POS Staging Layer

The first implementation milestone establishes a reliable staging layer between the POS OLTP source and the future dimensional warehouse.

### Completed Components
- `CM_SRC_POS`
- `CM_STG`
- `dbo.ETL_Batch`
- `dbo.ETL_Error_Log`
- Customer, Product, Store, Order, and OrderItem staging loads

### Standard Package Pattern

```text
SQL_Start_Batch
       ↓
SEQ_Process_<Entity>
       ├── SQL_Clear_STG_<Entity>
       └── DFT_Extract_POS_<Entity>
       ↓
Success → SQL_End_Batch_Success
Failure → SQL_End_Batch_Failed
```

Inside the Data Flow:

```text
SRC_POS_<Entity>
       ↓
DRV_ETL_Metadata
       ↓
CNT_Extracted_<Entity>
       ↓
DST_STG_<Entity>
```

### Standard ETL Metadata
- `BatchID`
- `ExtractedAt`
- `SourceSystem`

### Reconciliation
- Customers: 20,000
- Products: 320
- Stores: 12
- Orders: 50,000
- OrderItems: 150,000

### Next Technical Milestone
- Unknown members
- Surrogate keys
- SCD Type 1
- SCD Type 2
- Historical key resolution
- FactSales loading
