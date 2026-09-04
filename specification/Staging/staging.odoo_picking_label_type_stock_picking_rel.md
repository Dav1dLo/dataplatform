# odoo_picking_label_type_stock_picking_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `picking_label_type_id` and `stock_picking_id` is characteristic of Odoo's automated many-to-many relationship tables, which link custom configuration entities (picking label types) to core inventory movement objects (stock pickings).

## Functional process 
This table supports the inventory management and logistics process, specifically the association of custom label configurations or printing types with specific stock picking operations. It enables the system to track which label formats or types are assigned to or required for individual warehouse picking orders.

## Description
One row in this table represents a single association between a picking label type and a stock picking record. It serves as a raw landed join table in the staging layer, facilitating the resolution of many-to-many relationships between inventory operations and their associated labeling metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_label_type_id | INTEGER | false | Foreign key to the picking label type definition. | Represents the ID of the label configuration. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record. | Represents the ID of the specific inventory movement. |

## Keys

- **Primary key (inferred):** The combination of `(picking_label_type_id, stock_picking_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `picking_label_type_id` → `picking_label_type.id` (Inferred from Odoo naming convention for many-to-many relationship tables).
    - `stock_picking_id` → `stock_picking.id` (Inferred from Odoo naming convention for many-to-many relationship tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source.
- No timestamps are present; query writers cannot determine the creation or modification time of these associations from this table alone.