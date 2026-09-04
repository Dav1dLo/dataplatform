# odoo_product_template_attribute_value_sale_order_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `product_template_attribute_value` and `sale_order_line` is characteristic of Odoo's internal many-to-many relationship tables used to link configured product attributes to specific line items on a sales order.

## Functional process 
This table supports the Sales and Inventory configuration process. It tracks the specific attribute values (e.g., color, size, material) selected for a product variant at the time a sales order line is created, ensuring that the downstream fulfillment process knows exactly which configuration of a product was ordered.

## Description
One row represents a single association between a specific sales order line and a chosen product attribute value. This is a raw landing table representing a join entity in the Odoo database, used to resolve the many-to-many relationship between product configurations and sales order line items.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the specific line item in the sales order. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute option selected. |

## Keys

- **Primary key (inferred):** The combination of `sale_order_line_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `staging.sale_order_line.id`: This column references the primary key of the sales order line table.
    - `product_template_attribute_value_id` → `staging.product_template_attribute_value.id`: This column references the specific attribute value definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes other than the two foreign keys.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphans if the source Odoo system has experienced referential integrity issues during extraction.