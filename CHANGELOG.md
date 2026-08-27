# Changelog

## v0.4.0 - POS Staging Layer Complete
- Added staging loads for Customers, Products, Stores, Orders, and OrderItems.
- Added batch-level audit logging.
- Added centralized SSIS error logging.
- Added success and failure execution paths.
- Added row-count reconciliation.
- Added product source flattening through SQL joins.

## v0.3.0 - Error Handling
- Added Sequence Container execution pattern.
- Added failed-batch handling.
- Added `OnError` event logging.

## v0.2.0 - Audit Framework
- Added `ETL_Batch`.
- Added `BatchID` lineage.
- Added row-count metrics.

## v0.1.0 - Initial Staging
- Created SSIS project structure.
- Added POS and staging connections.
- Added first customer staging load.
