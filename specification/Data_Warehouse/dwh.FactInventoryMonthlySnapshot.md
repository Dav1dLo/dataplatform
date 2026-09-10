# Fully Qualified Name: dwh.FactInventoryMonthlySnapshot

## Description
Captures periodic monthly snapshot balances of stock inventory levels, reserved quantities, and financial valuation across products, warehouse locations, and stock lots. Supports historical on-hand trend analysis, financial stock balance reconciliation against general ledger assets, and warehouse utilization reporting.

## Grain
One row per snapshot month-end date, product variant, stock location, stock lot, and company. Periodic snapshot fact.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| dwh | InventoryMonthlySnapshotKey | PK | bigint | System-generated bigint surrogate key | Generated primary key using surrogate row sequence or hash across `SnapshotDateKey`, `ProductKey`, `LocationKey`, `StockLotKey`, and `CompanyId`. | |
| dwh | SnapshotDateKey | DD | integer | integer (YYYYMMDD) | Month-end calendar snapshot date key represented in integer format: `CAST(TO_CHAR(SnapshotDate, 'YYYYMMDD') AS integer)`. | |
| dwh | SnapshotDate | DD | date | date | Snapshot calculation date representing the final calendar day of the snapshot month. | |
| dwh | YearMonth | DD | varchar(7) | varchar(7) | Snapshot year and month in format 'YYYY-MM': `TO_CHAR(SnapshotDate, 'YYYY-MM')`. | |
| dwh | ProductKey | FK | integer | integer | Foreign key resolved by joining `staging.odoo_stock_quant.product_id` to [dwh.DimProduct](../dwh/DimProduct.md).`ProductBK` resolving to `ProductKey`. Default to `-1` if not found. | |
| dwh | LocationKey | FK | integer | integer | Foreign key resolved by joining `staging.odoo_stock_quant.location_id` to [dwh.DimLocation](../dwh/DimLocation.md).`LocationId` resolving to `LocationKey`. Default to `-1` if not found. | |
| dwh | StockLotKey | FK | integer | integer | Foreign key resolved by joining `staging.odoo_stock_quant.lot_id` to [dwh.DimStockLot](../dwh/DimStockLot.md).`StockLotId` resolving to `StockLotKey`. Default to `-1` for unassigned lots or null source lot references. | |
| dwh | CompanyId | DD | integer | integer | Source company identifier from `staging.odoo_stock_quant.company_id`. | |
| dwh | PackageId | DD | integer | integer | Container package identifier from `staging.odoo_stock_quant.package_id`. | |
| dwh | OwnerId | DD | integer | integer | Partner owner identifier for consignment inventory from `staging.odoo_stock_quant.owner_id`. | |
| dwh | StorageCategoryId | DD | integer | integer | Storage category categorization identifier from `staging.odoo_stock_quant.storage_category_id`. | |
| dwh | OnHandQuantity | SEMI | numeric(38,6) | numeric(38,6) | Month-end physical stock quantity on hand sourced from `staging.odoo_stock_quant.quantity`. (Source precision unknown → numeric(38,6)). | sum |
| dwh | ReservedQuantity | SEMI | numeric(38,6) | numeric(38,6) | Stock quantity reserved for outgoing orders/moves sourced from `staging.odoo_stock_quant.reserved_quantity`. (Source precision unknown → numeric(38,6)). | sum |
| dwh | AvailableQuantity | SEMI | numeric(38,6) | numeric(38,6) | Net available quantity calculated as `staging.odoo_stock_quant.quantity - staging.odoo_stock_quant.reserved_quantity`. (Arithmetic: scale = 6, precision = 38). | sum |
| dwh | UnitCost | NON | numeric(38,6) | numeric(38,6) | Latest recorded valuation layer unit cost for the product/lot as of snapshot date from `staging.odoo_stock_valuation_layer.unit_cost`. (Source precision unknown → numeric(38,6)). | average |
| dwh | TotalInventoryValuation | SEMI | numeric(38,6) | numeric(38,6) | Total financial valuation balance as of the snapshot month end. Calculated by multiplying `OnHandQuantity * UnitCost` or aggregated from `staging.odoo_stock_valuation_layer.remaining_value`. (Source precision unknown → numeric(38,6)). | sum |
| dwh | RemainingQuantity | SEMI | numeric(38,6) | numeric(38,6) | Cumulative open remaining quantity from valuation layers as of snapshot date from `staging.odoo_stock_valuation_layer.remaining_qty`. (Source precision unknown → numeric(38,6)). | sum |
| dwh | RemainingValuation | SEMI | numeric(38,6) | numeric(38,6) | Cumulative open remaining value from valuation layers as of snapshot date from `staging.odoo_stock_valuation_layer.remaining_value`. (Source precision unknown → numeric(38,6)). | sum |
| dwh | DwhCreatedAt | TC | timestamp | timestamp | System timestamp when the snapshot row was inserted into the Data Warehouse. | |
| dwh | DwhUpdatedAt | TC | timestamp | timestamp | System timestamp when the snapshot row was last updated in the Data Warehouse. | |

## Transformation Logic
1. **Periodic Snapshot Generation**:
   - Establish monthly snapshot intervals using the last calendar day of each month.
   - For historical month-ends, rebuild stock on hand per product, location, stock lot, and company by reconciling active stock quants (`staging.odoo_stock_quant`) alongside cumulative inventory valuation layers (`staging.odoo_stock_valuation_layer`) posted on or before the snapshot accounting cut-off date (`accounting_date <= SnapshotDate` or `create_date <= SnapshotDate`).
2. **Dimension Lookups & Key Resolution**:
   - Join to [dwh.DimProduct](../dwh/DimProduct.md) on `staging.odoo_stock_quant.product_id = DimProduct.ProductBK` to obtain `ProductKey`. Use default `-1` for unmatched products.
   - Join to [dwh.DimLocation](../dwh/DimLocation.md) on `staging.odoo_stock_quant.location_id = DimLocation.LocationId` to obtain `LocationKey`. Use default `-1` for unmatched locations.
   - Left join to [dwh.DimStockLot](../dwh/DimStockLot.md) on `staging.odoo_stock_quant.lot_id = DimStockLot.StockLotId` to obtain `StockLotKey`. If `lot_id` is null or not found, resolve to surrogate key `-1`.
3. **Valuation Layer Integration**:
   - From [staging.odoo_stock_valuation_layer](../staging/staging.odoo_stock_valuation_layer.md), aggregate `unit_cost`, `remaining_qty`, and `remaining_value` filtered up to the snapshot period (`create_date <= SnapshotDate + INTERVAL '1 day' - INTERVAL '1 microsecond'`).
   - Match valuation layers to quant grain on `product_id`, `company_id`, and `lot_id` (where valuated by lot).
4. **Calculations**:
   - Compute `AvailableQuantity` as `OnHandQuantity - ReservedQuantity`.
   - Compute `TotalInventoryValuation` as `COALESCE(RemainingValuation, OnHandQuantity * UnitCost)`.
5. **Idempotency & Load Strategy**:
   - The snapshot table is partitioned or idempotently replaced by `SnapshotDateKey`. Re-running a month-end snapshot job deletes and re-inserts that specific snapshot period.

## Lineage
- Reads from: [dwh.DimProduct](../dwh/DimProduct.md)
- Reads from: [dwh.DimLocation](../dwh/DimLocation.md)
- Reads from: [dwh.DimStockLot](../dwh/DimStockLot.md)
- Reads from: [staging.odoo_stock_quant](../staging/staging.odoo_stock_quant.md)
- Reads from: [staging.odoo_stock_valuation_layer](../staging/staging.odoo_stock_valuation_layer.md)

## Notes
- As a periodic snapshot fact, quantity and valuation measures are semi-additive: they can be aggregated across product, location, and lot hierarchies within a single snapshot date, but cannot be summed across time periods. Instead, average or point-in-time closing balances must be used across calendar dimensions.
- Locations include internal storage locations as well as transit, scrap, and supplier/customer consignment locations as defined in [dwh.DimLocation](../dwh/DimLocation.md). Analytical filters should filter on `DimLocation.LocationUsage = 'internal'` when calculating commercial balance-sheet inventory.
- For product categories using FIFO or AVCO costing, valuation layers in [staging.odoo_stock_valuation_layer](../staging/staging.odoo_stock_valuation_layer.md) provide the authoritative financial balances (`remaining_value`), ensuring direct alignment with the general ledger.