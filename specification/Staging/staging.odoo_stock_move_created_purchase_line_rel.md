# odoo_stock_move_created_purchase_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `move_id` and `created_purchase_line_id` is characteristic of Odoo's internal many-to-many relationship tables, which link stock movements to their originating purchase order lines.

## Functional process 
This table supports the procurement-to-inventory pipeline. It maintains the relational mapping between stock movement records (representing the physical receipt of goods) and the specific purchase order lines that authorized those receipts, ensuring traceability from inventory intake back to the procurement source.

## Description
One row in this table represents a single association between a stock movement record and a purchase order line. It serves as a raw, junction-table copy from the Odoo staging layer, used to resolve many-to-many relationships between inventory transactions and purchasing documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| created_purchase_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the source procurement record. |
| move_id | INTEGER | false | Foreign key to the stock move record | Links to the inventory movement record. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(created_purchase_line_id, move_id)`.
- **Foreign keys (inferred):** 
    - `created_purchase_line_id` → `purchase_order_line.id` (Evidence: naming convention matches Odoo standard relational linking).
    - `move_id` → `stock_move.id` (Evidence: naming convention matches Odoo standard relational linking).
- **Natural keys (inferred):** The combination of `(created_purchase_line_id, move_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; expect no descriptive attributes other than the two foreign keys.
- There is no audit timestamp (e.g., `created_at`) available in this table; rely on the parent `stock_move` or `purchase_order_line` tables for temporal context.
- Ensure inner joins are used with caution, as this table only contains records where a link exists; orphaned records in either parent table will not appear here.