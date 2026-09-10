# Fully Qualified Name: dwh.DimPickingType

## Description
Represents the configuration and operational classification of warehouse stock pickings and movements (e.g., Receipts, Delivery Orders, Internal Transfers, Manufacturing Operations). Provides business context for inventory transactions, including default locations, operational workflows, reservation policies, and associated warehouse designations.

## Grain
One row per stock picking operation type (`PickingTypeId`).

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| `PickingTypeKey` | `SK` | integer | integer | System-generated surrogate key (surrogate identity). |
| `PickingTypeId` | `BK` | integer | integer | Natural key from source. Direct mapping from `staging.odoo_stock_picking_type.id`. |
| `PickingTypeName` | `SCD1` | varchar(255) | varchar(255) | Multilingual JSON extraction with fallback: `COALESCE(staging.odoo_stock_picking_type.name->>'en_US', staging.odoo_stock_picking_type.name->>'en_GB', (SELECT value FROM jsonb_each_text(staging.odoo_stock_picking_type.name) LIMIT 1))::varchar(255)`. |
| `SequenceCode` | `SCD1` | varchar(255) | varchar(255) | Sequence prefix code used for reference numbering. Sourced from `staging.odoo_stock_picking_type.sequence_code::varchar(255)`. |
| `OperationCode` | `SCD1` | varchar(50) | varchar(50) | Technical operation code categorizing movement flow (e.g., 'incoming', 'outgoing', 'internal', 'mrp_operation'). Sourced from `staging.odoo_stock_picking_type.code::varchar(50)`. |
| `OperationCategory` | `SCD1` | varchar(50) | varchar(50) | Standardized human-readable operation classification derived from `code`: `CASE staging.odoo_stock_picking_type.code WHEN 'incoming' THEN 'Receipts' WHEN 'outgoing' THEN 'Delivery Orders' WHEN 'internal' THEN 'Internal Transfers' WHEN 'mrp_operation' THEN 'Manufacturing' ELSE INITCAP(REPLACE(staging.odoo_stock_picking_type.code, '_', ' ')) END::varchar(50)`. |
| `WarehouseId` | `SCD1` | integer | integer | Foreign identifier to the related warehouse. Sourced from `staging.odoo_stock_picking_type.warehouse_id`. |
| `WarehouseCode` | `SCD1` | varchar(5) | varchar(5) | Warehouse short code resolved via lookup: `staging.odoo_stock_warehouse.code`. |
| `WarehouseName` | `SCD1` | varchar(255) | varchar(255) | Warehouse descriptive name resolved via lookup: `staging.odoo_stock_warehouse.name::varchar(255)`. |
| `DefaultSourceLocationId` | `SCD1` | integer | integer | Default source location ID for this operation type. Sourced from `staging.odoo_stock_picking_type.default_location_src_id`. |
| `DefaultDestinationLocationId` | `SCD1` | integer | integer | Default destination location ID for this operation type. Sourced from `staging.odoo_stock_picking_type.default_location_dest_id`. |
| `ReturnPickingTypeId` | `SCD1` | integer | integer | Self-referencing ID pointing to the picking type used when handling returns. Sourced from `staging.odoo_stock_picking_type.return_picking_type_id`. |
| `CompanyId` | `SCD1` | integer | integer | Multi-company legal entity reference. Sourced from `staging.odoo_stock_picking_type.company_id`. |
| `ReservationMethod` | `SCD1` | varchar(50) | varchar(50) | Stock reservation strategy (e.g., 'at_confirm', 'manual', 'by_date'). Sourced from `staging.odoo_stock_picking_type.reservation_method::varchar(50)`. |
| `ReservationDaysBefore` | `SCD1` | integer | integer | Lead time in days prior to scheduled date to reserve stock. Sourced from `staging.odoo_stock_picking_type.reservation_days_before`. |
| `ReservationDaysBeforePriority` | `SCD1` | integer | integer | Priority lead time in days to reserve stock. Sourced from `staging.odoo_stock_picking_type.reservation_days_before_priority`. |
| `CreateBackorderPolicy` | `SCD1` | varchar(50) | varchar(50) | Backorder generation policy (e.g., 'always', 'ask', 'never'). Sourced from `staging.odoo_stock_picking_type.create_backorder::varchar(50)`. |
| `MoveType` | `SCD1` | varchar(50) | varchar(50) | Delivery grouping policy (e.g., 'direct', 'one'). Sourced from `staging.odoo_stock_picking_type.move_type::varchar(50)`. |
| `Barcode` | `SCD1` | varchar(255) | varchar(255) | Barcode representation for barcode scanner handling. Sourced from `staging.odoo_stock_picking_type.barcode::varchar(255)`. |
| `SequenceOrder` | `SCD1` | integer | integer | Sequence display ordering in source UI. Sourced from `staging.odoo_stock_picking_type.sequence`. |
| `UseCreateLots` | `SCD1` | boolean | boolean | Flag indicating whether new lot/serial numbers can be created during this picking type. Sourced from `staging.odoo_stock_picking_type.use_create_lots`. |
| `UseExistingLots` | `SCD1` | boolean | boolean | Flag indicating whether existing lot/serial numbers are selected during this picking type. Sourced from `staging.odoo_stock_picking_type.use_existing_lots`. |
| `ShowEntirePacks` | `SCD1` | boolean | boolean | Flag indicating whether entire package details are displayed. Sourced from `staging.odoo_stock_picking_type.show_entire_packs`. |
| `ShowOperations` | `SCD1` | boolean | boolean | Flag indicating whether detailed operation lines are displayed. Sourced from `staging.odoo_stock_picking_type.show_operations`. |
| `IsActive` | `SCD1` | boolean | boolean | Soft delete indicator; true if picking type is active. Sourced from `staging.odoo_stock_picking_type.active`. |

## Transformation Logic
- Load records from [staging.odoo_stock_picking_type](../Staging/staging.odoo_stock_picking_type.md) as the primary driving table.
- Left join to [staging.odoo_stock_warehouse](../Staging/staging.odoo_stock_warehouse.md) on `staging.odoo_stock_picking_type.warehouse_id = staging.odoo_stock_warehouse.id` to retrieve warehouse context (`name`, `code`).
- Multilingual name resolution: Extract the English translation from the JSONB column `name` with fallback to any available language key: `COALESCE(name->>'en_US', name->>'en_GB', (SELECT value FROM jsonb_each_text(name) LIMIT 1))`.
- Operational categorization: Standardize the `code` attribute into user-friendly names (`incoming` -> `Receipts`, `outgoing` -> `Delivery Orders`, `internal` -> `Internal Transfers`, `mrp_operation` -> `Manufacturing`).
- Include all configuration records regardless of `active` flag status to ensure complete historical movement classification integrity.
- Managed as a Type 1 dimension (`SCD1`), overwriting configuration changes in place.

## Lineage
- Reads from: [staging.odoo_stock_picking_type](../Staging/staging.odoo_stock_picking_type.md)
- Reads from: [staging.odoo_stock_warehouse](../Staging/staging.odoo_stock_warehouse.md)

## Notes
- Picking types without an associated warehouse (e.g., company-wide inter-warehouse transit pickings) will have null `WarehouseId`, `WarehouseCode`, and `WarehouseName`.
- `DefaultSourceLocationId` and `DefaultDestinationLocationId` represent default configurations for pickings of this type, which may be overridden at the individual movement line level in transactional facts.