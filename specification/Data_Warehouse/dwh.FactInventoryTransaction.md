# Fully Qualified Name: dwh.FactInventoryTransaction

## Description
Captures granular inventory movement transactions and stock execution events across products, locations, lots/serial numbers, and business partners. Integrates operational stock move lines with picking context, financial inventory valuation layers, and scrap event tracking to enable inventory quantity reconciliation, cost impact valuation, and flow analysis.

## Grain
One row per completed stock move line (`staging.odoo_stock_move_line.id`). Transaction fact.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| dwh | InventoryTransactionKey | PK | bigint | bigint | Surrogate primary key generated via identity or row number over `staging.odoo_stock_move_line.id`. | |
| dwh | StockMoveLineID | DD | integer | integer | Source operational key from `staging.odoo_stock_move_line.id`. | |
| dwh | StockMoveID | DD | integer | integer | Source parent move identifier from `staging.odoo_stock_move_line.move_id`. | |
| dwh | StockPickingID | DD | integer | integer | Source parent picking identifier: `COALESCE(staging.odoo_stock_move_line.picking_id, staging.odoo_stock_move.picking_id)`. | |
| dwh | ScrapID | DD | integer | integer | Source scrap operation identifier from `staging.odoo_stock_move.scrap_id`. | |
| dwh | ProductKey | FK | integer | integer | Surrogate key resolving to [dwh.DimProduct](../dwh/Dimension/dwh.DimProduct.md).`ProductKey` via `staging.odoo_stock_move_line.product_id = dwh.DimProduct.ProductBK`. Defaults to -1 when unmapped. | |
| dwh | SourceLocationKey | FK | integer | integer | Surrogate key resolving to [dwh.DimLocation](../dwh/Dimension/dwh.DimLocation.md).`LocationKey` via `staging.odoo_stock_move_line.location_id = dwh.DimLocation.LocationId`. Defaults to -1 when unmapped. | |
| dwh | DestinationLocationKey | FK | integer | integer | Surrogate key resolving to [dwh.DimLocation](../dwh/Dimension/dwh.DimLocation.md).`LocationKey` via `staging.odoo_stock_move_line.location_dest_id = dwh.DimLocation.LocationId`. Defaults to -1 when unmapped. | |
| dwh | StockLotKey | FK | integer | integer | Surrogate key resolving to [dwh.DimStockLot](../dwh/Dimension/dwh.DimStockLot.md).`StockLotKey` via `staging.odoo_stock_move_line.lot_id = dwh.DimStockLot.StockLotId`. Defaults to -1 when unmapped or null. | |
| dwh | PartnerKey | FK | integer | integer | Surrogate key resolving to [dwh.DimPartner](../dwh/Dimension/dwh.DimPartner.md).`PartnerKey` via `COALESCE(staging.odoo_stock_move.partner_id, staging.odoo_stock_picking.partner_id) = dwh.DimPartner.PartnerID`. Defaults to -1 when unmapped or null. | |
| dwh | PickingTypeKey | FK | integer | integer | Surrogate key resolving to [dwh.DimPickingType](../dwh/Dimension/dwh.DimPickingType.md).`PickingTypeKey` via `COALESCE(staging.odoo_stock_move.picking_type_id, staging.odoo_stock_picking.picking_type_id) = dwh.DimPickingType.PickingTypeId`. Defaults to -1 when unmapped or null. | |
| dwh | MovementDate | DD | timestamp | timestamp | Effective transaction timestamp from `staging.odoo_stock_move_line.date`. | |
| dwh | MovementDateKey | FK | integer | integer | Integer date key formatted as `YYYYMMDD` derived from `staging.odoo_stock_move_line.date`. | |
| dwh | CompanyId | DD | integer | integer | Multi-company legal entity identifier: `COALESCE(staging.odoo_stock_move_line.company_id, staging.odoo_stock_move.company_id)`. | |
| dwh | MovementState | DD | varchar(50) | varchar(50) | Operational state of the move line: `staging.odoo_stock_move_line.state` (source precision unknown → varchar(50)). | |
| dwh | ReferenceDocument | DD | varchar(255) | varchar(255) | Operational reference string: `COALESCE(staging.odoo_stock_move_line.reference, staging.odoo_stock_move.reference, staging.odoo_stock_picking.name)` (source precision unknown → varchar(255)). | |
| dwh | OriginDocument | DD | varchar(255) | varchar(255) | Source originating document code: `COALESCE(staging.odoo_stock_move.origin, staging.odoo_stock_picking.origin)` (source precision unknown → varchar(255)). | |
| dwh | ScrapReasonCode | DD | varchar(255) | varchar(255) | Human-readable scrap identifier or origin: `staging.odoo_stock_scrap.name` (source precision unknown → varchar(255)). | |
| dwh | MovementType | DD | varchar(50) | varchar(50) | Categorization of movement flow based on source and destination location usage from `dwh.DimLocation`: `CASE WHEN src.LocationUsage = 'internal' AND dst.LocationUsage != 'internal' THEN 'Outbound' WHEN src.LocationUsage != 'internal' AND dst.LocationUsage = 'internal' THEN 'Inbound' WHEN src.LocationUsage = 'internal' AND dst.LocationUsage = 'internal' THEN 'Internal Transfer' ELSE 'Other' END`. | |
| dwh | IsScrapped | DD | boolean | boolean | Flag indicating whether the move line represents scrap: `COALESCE(staging.odoo_stock_move.scrapped, staging.odoo_stock_move.scrap_id IS NOT NULL, FALSE)`. | |
| dwh | IsInventoryAdjustment | DD | boolean | boolean | Flag indicating whether the move line represents an inventory count adjustment: `COALESCE(staging.odoo_stock_move.is_inventory, FALSE)`. | |
| dwh | QuantityMoved | ADD | numeric(38,6) | numeric(38,6) | Actual quantity moved expressed in product standard unit of measure from `staging.odoo_stock_move_line.quantity`. Source precision unknown → numeric(38,6). | sum |
| dwh | QuantityProductUom | ADD | numeric(38,6) | numeric(38,6) | Actual quantity moved expressed in operational unit of measure from `staging.odoo_stock_move_line.quantity_product_uom`. Source precision unknown → numeric(38,6). | sum |
| dwh | DemandQuantity | ADD | numeric(38,6) | numeric(38,6) | Allocated planned/initial demand quantity from `staging.odoo_stock_move.product_uom_qty` prorated across line items if multiple, else direct: `staging.odoo_stock_move.product_uom_qty`. Source precision unknown → numeric(38,6). | sum |
| dwh | UnitCost | NON | numeric(38,6) | numeric(38,6) | Valuation unit cost at transaction time: `COALESCE(val.unit_cost, CAST(staging.odoo_stock_move.price_unit AS numeric(38,6)), 0.0)`. Source precision unknown → numeric(38,6). | |
| dwh | ValuationAmount | ADD | numeric(38,6) | numeric(38,6) | Financial asset value impact of movement: `COALESCE(val.value, staging.odoo_stock_move_line.quantity * COALESCE(val.unit_cost, CAST(staging.odoo_stock_move.price_unit AS numeric(38,6)), 0.0))`. Source precision unknown → numeric(38,6). | sum |
| dwh | ScrapQuantity | ADD | numeric(38,6) | numeric(38,6) | Quantity scrapped: `CASE WHEN COALESCE(staging.odoo_stock_move.scrapped, FALSE) = TRUE THEN staging.odoo_stock_move_line.quantity ELSE 0.0 END`. Source precision unknown → numeric(38,6). | sum |

## Transformation Logic
- **Base Driving Selection**:
  - Source records from [staging.odoo_stock_move_line](../staging/staging.odoo_stock_move_line.md) filtering for completed movements where `state = 'done'`.
- **Joins to Staging Tables**:
  - Left outer join to [staging.odoo_stock_move](../staging/staging.odoo_stock_move.md) on `staging.odoo_stock_move_line.move_id = staging.odoo_stock_move.id` to retrieve movement metadata (`scrap_id`, `scrapped`, `is_inventory`, `product_uom_qty`, `price_unit`, `origin`).
  - Left outer join to [staging.odoo_stock_picking](../staging/staging.odoo_stock_picking.md) on `COALESCE(staging.odoo_stock_move_line.picking_id, staging.odoo_stock_move.picking_id) = staging.odoo_stock_picking.id` to retrieve picking document attributes.
  - Left outer join to [staging.odoo_stock_scrap](../staging/staging.odoo_stock_scrap.md) on `staging.odoo_stock_move.scrap_id = staging.odoo_stock_scrap.id` to retrieve scrap reference details.
  - Left outer join to aggregated financial layer [staging.odoo_stock_valuation_layer](../staging/staging.odoo_stock_valuation_layer.md) grouped by `stock_move_id` (or move and lot where applicable) to retrieve `unit_cost` and transaction `value`.
- **Dimension Key Lookups**:
  - Join to [dwh.DimProduct](../dwh/Dimension/dwh.DimProduct.md) on `staging.odoo_stock_move_line.product_id = dwh.DimProduct.ProductBK` to obtain `ProductKey`.
  - Join to [dwh.DimLocation](../dwh/Dimension/dwh.DimLocation.md) (as `src`) on `staging.odoo_stock_move_line.location_id = src.LocationId` to obtain `SourceLocationKey`.
  - Join to [dwh.DimLocation](../dwh/Dimension/dwh.DimLocation.md) (as `dst`) on `staging.odoo_stock_move_line.location_dest_id = dst.LocationId` to obtain `DestinationLocationKey`.
  - Left outer join to [dwh.DimStockLot](../dwh/Dimension/dwh.DimStockLot.md) on `staging.odoo_stock_move_line.lot_id = dwh.DimStockLot.StockLotId` to obtain `StockLotKey`.
  - Left outer join to [dwh.DimPartner](../dwh/Dimension/dwh.DimPartner.md) on `COALESCE(staging.odoo_stock_move.partner_id, staging.odoo_stock_picking.partner_id) = dwh.DimPartner.PartnerID` to obtain `PartnerKey`.
  - Left outer join to [dwh.DimPickingType](../dwh/Dimension/dwh.DimPickingType.md) on `COALESCE(staging.odoo_stock_move.picking_type_id, staging.odoo_stock_picking.picking_type_id) = dwh.DimPickingType.PickingTypeId` to obtain `PickingTypeKey`.
- **Null / Missing Value Handling**:
  - Unmatched dimension lookups fall back to default `-1` surrogate keys.
  - Null numerical metrics default to `0.0`.

## Lineage
- Reads from: [staging.odoo_stock_move_line](../staging/staging.odoo_stock_move_line.md)
- Reads from: [staging.odoo_stock_move](../staging/staging.odoo_stock_move.md)
- Reads from: [staging.odoo_stock_picking](../staging/staging.odoo_stock_picking.md)
- Reads from: [staging.odoo_stock_valuation_layer](../staging/staging.odoo_stock_valuation_layer.md)
- Reads from: [staging.odoo_stock_scrap](../staging/staging.odoo_stock_scrap.md)
- Reads from: [dwh.DimProduct](../dwh/Dimension/dwh.DimProduct.md)
- Reads from: [dwh.DimLocation](../dwh/Dimension/dwh.DimLocation.md)
- Reads from: [dwh.DimStockLot](../dwh/Dimension/dwh.DimStockLot.md)
- Reads from: [dwh.DimPartner](../dwh/Dimension/dwh.DimPartner.md)
- Reads from: [dwh.DimPickingType](../dwh/Dimension/dwh.DimPickingType.md)

## Notes
- Modelled as a Kimball transaction fact table. Records are immutable once the underlying stock move line reaches the `done` state.
- In multi-company environments, `CompanyId` isolates operational movements across entities.
- Financial cost valuation maps from `staging.odoo_stock_valuation_layer`. For standard or average costing items where valuation layers are not generated, fallback is evaluated against `staging.odoo_stock_move.price_unit`.