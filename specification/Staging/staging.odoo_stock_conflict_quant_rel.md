# odoo_stock_conflict_quant_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_conflict_quant_rel` is characteristic of Odoo's internal many-to-many relationship tables, which typically use the `_rel` suffix to link two primary entities—in this case, inventory conflict records and stock quant records.

## Functional process 
This table supports the inventory management and reconciliation process. It acts as a bridge between inventory conflict reports (which track discrepancies in stock levels) and specific stock quants (which represent the smallest unit of stock in a specific location with specific attributes), allowing the system to associate multiple quants with a single inventory conflict event.

## Description
Each row represents a single association between an inventory conflict record and a stock quant record. This is a link table used to resolve many-to-many relationships within the Odoo inventory module. It serves as a raw landed copy of the relationship mapping, intended for use in joining inventory discrepancy data with detailed stock quant information.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_conflict_id | INTEGER | false | Foreign key to the inventory conflict record. | Links to the parent conflict event. |
| stock_quant_id | INTEGER | false | Foreign key to the specific stock quant record. | Identifies the specific stock unit involved in the conflict. |

## Keys

- **Primary key (inferred):** The combination of `(stock_inventory_conflict_id, stock_quant_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_inventory_conflict_id` → `stock_inventory_conflict.id` (inferred from naming convention).
    - `stock_quant_id` → `stock_quant.id` (inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only foreign keys; it must be joined with the parent tables to provide meaningful business context.
- As a relationship table, it does not contain timestamps or soft-delete flags; refer to the parent `stock_inventory_conflict` table for audit or lifecycle information.
- Ensure that joins are performed on both columns to maintain the integrity of the many-to-many relationship.