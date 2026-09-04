# odoo_template_attribute_value_stock_move_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `template_attribute_value` and `stock_move` is characteristic of Odoo's internal many-to-many relationship tables used to link product attribute values to specific stock movement records.

## Functional process 
This table supports the inventory management and product configuration process. It tracks the association between specific stock moves (the movement of goods) and the product attribute values (e.g., color, size, or material) that define the variant being moved, ensuring that inventory tracking accounts for product configuration details.

## Description
One row in this table represents a single link between a stock movement record and a specific product attribute value. This is a raw landing of an Odoo join table, serving as a bridge to resolve many-to-many relationships between inventory transactions and product variants in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_id | INTEGER | false | Foreign key to the stock move record | Links to the primary stock movement table. |
| template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute variant involved. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(move_id, template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `move_id` → `stock_move.id` (Inferred from Odoo naming conventions for relational tables).
    - `template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from Odoo naming conventions for relational tables).
- **Natural keys (inferred):** The combination of `(move_id, template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; rely on the parent `stock_move` table for temporal context.
- Ensure inner joins are used when traversing to parent tables to avoid orphaned records, as this table enforces referential integrity at the application level.