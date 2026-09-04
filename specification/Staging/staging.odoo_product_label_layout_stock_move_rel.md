# odoo_product_label_layout_stock_move_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is standard for Odoo's many-to-many join tables, which are used to link records across different modules—in this case, linking product label layout configurations to specific stock movement records.

## Functional process 
This table supports the inventory management and logistics process, specifically the generation of product labels during stock operations. It facilitates the association between a label layout configuration and the specific stock moves that require labeling, ensuring that the correct label format is applied to the items being moved.

## Description
One row in this table represents a single association between a product label layout configuration and a stock move record. It serves as a raw, junction-table copy from the Odoo source system, maintaining the many-to-many relationship required for batch label printing operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_label_layout_id | INTEGER | false | Foreign key to the product label layout definition. | References the configuration settings for label printing. |
| stock_move_id | INTEGER | false | Foreign key to the specific stock move record. | Identifies the inventory movement associated with the label. |

## Keys

- **Primary key (inferred):** The composite of `(product_label_layout_id, stock_move_id)`.
- **Foreign keys (inferred):** 
    - `product_label_layout_id → product_label_layout.id`: This column links to the configuration entity for label layouts.
    - `stock_move_id → stock_move.id`: This column links to the core inventory movement entity.
- **Natural keys (inferred):** Not confidently inferable; this is a technical join table.

## Caveats for downstream consumers

- This is a junction table; queries should expect many-to-many relationships between layouts and stock moves.
- There are no timestamps or audit columns present; this table reflects the current state of associations in the source system.
- Ensure joins to `product_label_layout` and `stock_move` are handled as inner or left joins depending on whether you require the existence of both related entities.