# Fully Qualified Name: dwh.DimLocation

## Description
Represents inventory stock locations, warehouse sub-structures, aisles, shelves, transit points, customer/vendor locations, and scrap zones within the enterprise. Combines granular location hierarchies from Odoo stock locations with parent warehouse attributes to provide dimensional slicing for stock movements and on-hand reporting.

## Grain
One row per stock location (`staging.odoo_stock_location.id`).

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| `LocationKey` | SK | integer | integer | System-generated surrogate primary key. |
| `LocationId` | BK | integer | integer | Pass-through from `staging.odoo_stock_location.id`. |
| `LocationName` | SCD1 | varchar(255) | varchar(255) | Pass-through from `staging.odoo_stock_location.name`. Documented default varchar(255) for Odoo unbounded varchar. |
| `LocationCompleteName` | SCD1 | varchar(500) | varchar(500) | Pass-through from `staging.odoo_stock_location.complete_name`. Sized wide enough to accommodate multi-level path hierarchies. |
| `LocationUsage` | SCD1 | varchar(50) | varchar(50) | Pass-through from `staging.odoo_stock_location.usage` (e.g., 'internal', 'transit', 'customer', 'supplier', 'inventory', 'production'). |
| `LocationBarcode` | SCD1 | varchar(255) | varchar(255) | Pass-through from `staging.odoo_stock_location.barcode`. |
| `ParentLocationId` | SCD1 | integer | integer | Pass-through from `staging.odoo_stock_location.location_id`. |
| `ParentPath` | SCD1 | varchar(255) | varchar(255) | Pass-through from `staging.odoo_stock_location.parent_path`. |
| `WarehouseId` | SCD1 | integer | integer | Sourced from `staging.odoo_stock_location.warehouse_id`. |
| `WarehouseCode` | SCD1 | varchar(5) | varchar(5) | Sourced via left join to `staging.odoo_stock_warehouse.code` on `staging.odoo_stock_location.warehouse_id = staging.odoo_stock_warehouse.id`. |
| `WarehouseName` | SCD1 | varchar(255) | varchar(255) | Sourced via left join to `staging.odoo_stock_warehouse.name` on `staging.odoo_stock_location.warehouse_id = staging.odoo_stock_warehouse.id`. Documented default varchar(255). |
| `CompanyId` | SCD1 | integer | integer | Coalesce of `staging.odoo_stock_location.company_id` and `staging.odoo_stock_warehouse.company_id`. |
| `CoordinateX` | SCD1 | integer | integer | Pass-through from `staging.odoo_stock_location.posx`. |
| `CoordinateY` | SCD1 | integer | integer | Pass-through from `staging.odoo_stock_location.posy`. |
| `CoordinateZ` | SCD1 | integer | integer | Pass-through from `staging.odoo_stock_location.posz`. |
| `IsScrapLocation` | SCD1 | boolean | boolean | Pass-through from `staging.odoo_stock_location.scrap_location`. Default to `FALSE` if null. |
| `IsReplenishLocation` | SCD1 | boolean | boolean | Pass-through from `staging.odoo_stock_location.replenish_location`. Default to `FALSE` if null. |
| `IsActive` | SCD1 | boolean | boolean | Pass-through from `staging.odoo_stock_location.active`. Default to `TRUE` if null. |
| `CyclicInventoryFrequency` | SCD1 | integer | integer | Pass-through from `staging.odoo_stock_location.cyclic_inventory_frequency`. |
| `LastInventoryDate` | SCD1 | date | date | Pass-through from `staging.odoo_stock_location.last_inventory_date`. |
| `NextInventoryDate` | SCD1 | date | date | Pass-through from `staging.odoo_stock_location.next_inventory_date`. |
| `Comment` | SCD1 | text | text | Pass-through from `staging.odoo_stock_location.comment`. |

## Transformation Logic
1. **Source Selection & Base Grain**:
   - Read all records from [staging.odoo_stock_location](../staging/staging.odoo_stock_location.md).
2. **Joins & Lookups**:
   - Left join [staging.odoo_stock_warehouse](../staging/staging.odoo_stock_warehouse.md) on `staging.odoo_stock_location.warehouse_id = staging.odoo_stock_warehouse.id` to enrich locations with parent warehouse attributes (`code`, `name`, fallback `company_id`).
3. **Surrogate Key Generation**:
   - Generate `LocationKey` as a synthetic surrogate key (e.g., via identity or window sequence over `LocationId`).
4. **Standardisation & Null Handling**:
   - Default boolean flags `scrap_location`, `replenish_location`, and `active` to false/true appropriately when null in source.
   - For `CompanyId`, use `COALESCE(staging.odoo_stock_location.company_id, staging.odoo_stock_warehouse.company_id)`.
   - Include special surrogate key record `-1` / `'Unknown'` for missing or non-resolved location references in downstream fact loads.

## Lineage
- Reads from: [staging.odoo_stock_location](../staging/staging.odoo_stock_location.md)
- Reads from: [staging.odoo_stock_warehouse](../staging/staging.odoo_stock_warehouse.md)

## Notes
- `dwh.DimLocation` is modelled as a Type 1 (SCD1) dimension tracking the current warehouse and location topology. Historical inventory movements capture their spatial context at the transaction timestamp, while analytical queries require current location groupings.
- Not all locations have an explicit `warehouse_id` populated in Odoo (for example, physical transit locations, virtual scrap locations, or external customer/supplier locations). A `LEFT JOIN` to `staging.odoo_stock_warehouse` ensures these valid operational locations are preserved with null warehouse attributes.