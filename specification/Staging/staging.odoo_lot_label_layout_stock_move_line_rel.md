# odoo_lot_label_layout_stock_move_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` indicates a join table used to manage a many-to-many relationship between the `lot_label_layout` wizard/model and the `stock_move_line` inventory tracking model.

## Functional process 
This table supports the inventory management and label printing process. It tracks which specific stock move lines (representing items being moved or picked) are associated with a specific lot label layout configuration, allowing users to batch-print labels for items in a stock move.

## Description
One row represents a single association between a lot label layout configuration and a stock move line. This is a raw landing of a many-to-many join table, serving as a bridge to resolve the relationship between inventory movements and their corresponding label printing parameters.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| lot_label_layout_id | INTEGER | false | Foreign key to the lot label layout configuration. | References the parent layout record. |
| stock_move_line_id | INTEGER | false | Foreign key to the stock move line record. | References the specific inventory move line. |

## Keys

- **Primary key (inferred):** The combination of `(lot_label_layout_id, stock_move_line_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `lot_label_layout_id` → `lot_label_layout.id` (Inferred from Odoo naming conventions for join tables).
    - `stock_move_line_id` → `stock_move_line.id` (Inferred from Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to the parent tables handle the potential for missing records if the source Odoo instance has experienced data integrity issues or partial deletions.