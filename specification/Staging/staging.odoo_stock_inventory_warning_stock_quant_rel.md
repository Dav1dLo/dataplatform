# odoo_stock_inventory_warning_stock_quant_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_inventory_warning_stock_quant_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link inventory warning records to specific stock quantity records.

## Functional process 
This table supports the inventory management and stock reconciliation process. It acts as a join table that associates specific inventory warnings (likely generated during stock counts or adjustments) with the underlying stock quant records that triggered or are affected by those warnings.

## Description
One row in this table represents a single association between an inventory warning record and a stock quantity record. It is a raw landed copy of an Odoo join table, serving as the bridge to resolve many-to-many relationships between inventory alerts and specific stock quant entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_warning_id | INTEGER | false | Foreign key to the inventory warning record | Links to the parent warning entity. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity entry. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(stock_inventory_warning_id, stock_quant_id)`.
- **Foreign keys (inferred):** 
    - `stock_inventory_warning_id` → `stock_inventory_warning.id` (guess: standard Odoo naming convention for relational tables).
    - `stock_quant_id` → `stock_quant.id` (guess: standard Odoo naming convention for relational tables).
- **Natural keys (inferred):** The combination of `(stock_inventory_warning_id, stock_quant_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure inner joins are used when traversing to parent tables to avoid orphaned records if the source system has referential integrity gaps.