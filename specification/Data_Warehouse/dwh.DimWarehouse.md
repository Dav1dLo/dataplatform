# Fully Qualified Name: dwh.DimWarehouse

## Description
This dimension table represents the physical and logical warehouse facilities within the organization. It provides descriptive attributes for warehouses, including their operational codes, names, and associated hierarchical location information, enabling analysis of procurement and inventory activities by warehouse site.

## Grain
One row per warehouse.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| WarehouseKey | SK | integer | integer | System-generated surrogate key. |
| WarehouseBK | BK | integer | integer | Source `staging.odoo_stock_warehouse.id`. |
| WarehouseName | SCD1 | varchar(255) | varchar(255) | Source `staging.odoo_stock_warehouse.name`. |
| WarehouseCode | SCD1 | varchar(5) | varchar(5) | Source `staging.odoo_stock_warehouse.code`. |
| DefaultStockLocationName | SCD1 | varchar(255) | varchar(255) | Lookup `staging.odoo_stock_location.complete_name` where `staging.odoo_stock_location.id` = `staging.odoo_stock_warehouse.lot_stock_id`. |
| IsActive | SCD1 | boolean | boolean | Source `staging.odoo_stock_warehouse.active`. |

## Transformation Logic
The table is populated by selecting active records from `staging.odoo_stock_warehouse`. The `DefaultStockLocationName` is resolved by joining the warehouse's default stock location ID (`lot_stock_id`) against the `staging.odoo_stock_location` table to retrieve the human-readable hierarchical path.

## Lineage
- Reads from: [staging.odoo_stock_warehouse](../Staging/staging.odoo_stock_warehouse.md)
- Reads from: [staging.odoo_stock_location](../Staging/staging.odoo_stock_location.md)

## Notes
- The `WarehouseBK` corresponds to the Odoo internal ID.
- `IsActive` should be used to filter out inactive warehouses in downstream reports.
- The `DefaultStockLocationName` provides context on the primary storage area associated with the warehouse.