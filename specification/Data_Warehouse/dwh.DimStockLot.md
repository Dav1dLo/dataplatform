# Fully Qualified Name: dwh.DimStockLot

## Description
Represents individual inventory lots and serial numbers tracked across products, locations, and companies within the warehouse management system. Enables granular batch traceability, product origin tracking, internal reference identification, and quality or recall analysis.

## Grain
One row per lot or serial number record (one row per `id` in Odoo inventory).

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| StockLotKey | SK | integer | integer | System-generated surrogate primary key. |
| StockLotId | BK | integer | integer | Natural business key directly mapped from staging.odoo_stock_lot.id. |
| LotNumber | SCD1 | varchar(255) | varchar(255) | Name/number identifier of the lot or serial, directly mapped from staging.odoo_stock_lot.name. Sized to varchar(255) as staging precision is unconstrained varchar. |
| InternalReference | SCD1 | varchar(255) | varchar(255) | Optional internal reference code mapped from staging.odoo_stock_lot.ref. Sized to varchar(255) as staging precision is unconstrained varchar. |
| SourceProductId | SCD1 | integer | integer | Source identifier linking to the associated product catalog item, mapped from staging.odoo_stock_lot.product_id. |
| SourceProductUomId | SCD1 | integer | integer | Source unit of measure identifier for the lot, mapped from staging.odoo_stock_lot.product_uom_id. |
| SourceCompanyId | SCD1 | integer | integer | Source identifier for the owning legal entity or operational company, mapped from staging.odoo_stock_lot.company_id. |
| SourceLocationId | SCD1 | integer | integer | Source identifier for the default or initial warehouse location, mapped from staging.odoo_stock_lot.location_id. |
| LotNotes | SCD1 | varchar(2000) | varchar(2000) | Free-text operational comments or notes regarding the lot, mapped from staging.odoo_stock_lot.note. Cast/sized to varchar(2000) to safely capture detailed notes. |
| SourceCreatedAt | SCD1 | timestamp | timestamp | The timestamp when the lot was created in the source system, mapped from staging.odoo_stock_lot.create_date. |
| SourceUpdatedAt | SCD1 | timestamp | timestamp | The timestamp when the lot record was last updated in the source system, mapped from staging.odoo_stock_lot.write_date. |

## Transformation Logic
- Source data is extracted from `staging.odoo_stock_lot`.
- Deduplication is performed on `staging.odoo_stock_lot.id` to guarantee the grain of one row per stock lot identifier.
- Pure Type 1 dimension handling; updates to lot attributes in the operational system overwrite the existing dimension record attributes in place.
- String fields (`name`, `ref`, and `note`) are trimmed. Unbounded source text/varchar fields are assigned standard sizing (`varchar(255)` for identifiers/references, `varchar(2000)` for free-form notes).
- Unknown/default member with `StockLotKey = -1`, `StockLotId = -1`, `LotNumber = 'Unknown'`, and default values across all attributes is prepended for late-arriving dimensions or unassigned inventory movements.

## Lineage
- Reads from: [staging.odoo_stock_lot](../Staging/staging.odoo_stock_lot.md)

## Notes
- `lot_properties` and `standard_price` are JSONB fields in staging; specific keys or metrics can be extracted into dedicated dimensional attributes or fact pricing metrics in future iterations as business requirements dictate.
- Downstream fact tables `dwh.FactInventoryTransaction` and `dwh.FactInventoryMonthlySnapshot` link directly to `StockLotKey` via foreign key reference.