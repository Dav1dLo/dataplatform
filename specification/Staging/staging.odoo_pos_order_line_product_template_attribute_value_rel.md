# odoo_pos_order_line_product_template_attribute_value_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `pos_order_line` and `product_template_attribute_value` is characteristic of Odoo's internal many-to-many relationship tables used to link POS order line items to specific product attribute configurations (e.g., color, size).

## Functional process 
This table supports the Point of Sale (POS) order processing pipeline. It acts as a bridge to track which specific attribute values (such as "Size: Large" or "Color: Blue") were selected for a product within a specific POS order line, ensuring that the inventory and sales reporting reflect the exact variant sold.

## Description
One row represents a single association between a POS order line and a specific product attribute value. It is a raw landing copy of an Odoo join table, serving as the bridge to resolve many-to-many relationships between order items and product configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_order_line_id | INTEGER | false | Foreign key to the POS order line | Links to the specific line item in the order. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute variant selected. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `pos_order_line_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `pos_order_line_id` → `staging.pos_order_line.id`: This column references the primary key of the POS order line table.
    - `product_template_attribute_value_id` → `staging.product_template_attribute_value.id`: This column references the definition of the attribute value.
- **Natural keys (inferred):** The combination of `(pos_order_line_id, product_template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of the relationship as defined in the source Odoo database.
- Ensure joins to parent tables handle potential missing records if the source system performs cascading deletes or if data ingestion is partial.