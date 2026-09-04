# odoo_stock_inventory_conflict_stock_quant_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_inventory_conflict_stock_quant_rel` follows the standard Odoo pattern for a many-to-many join table, specifically linking inventory conflict records to stock quant records within the warehouse management module.

## Functional process 
This table supports the inventory reconciliation and conflict resolution process. It maps specific stock quant records (representing physical stock levels) to inventory conflict events, allowing the system to track which inventory items are involved in a reported discrepancy or reconciliation conflict.

## Description
One row in this table represents a single association between an inventory conflict record and a stock quant record. It serves as a raw, junction-table copy from the Odoo source, facilitating the many-to-many relationship required for inventory audit tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_conflict_id | INTEGER | false | Foreign key to the inventory conflict record | Links to the parent conflict event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity record involved. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `stock_inventory_conflict_id` and `stock_quant_id`.
- **Foreign keys (inferred):** 
    - `stock_inventory_conflict_id` → `stock_inventory_conflict.id` (Inferred from Odoo naming conventions).
    - `stock_quant_id` → `stock_quant.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of `(stock_inventory_conflict_id, stock_quant_id)` acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or soft-delete flags present; this table represents the current state of relationships as ingested from the source.
- Ensure joins to parent tables handle potential orphans if the source system has inconsistent referential integrity.