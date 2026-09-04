# odoo_product_template_attribute_value_purchase_order_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names (`product_template_attribute_value` and `purchase_order_line`) is characteristic of Odoo's internal many-to-many relationship tables used to link product configuration attributes to specific line items on purchase orders.

## Functional process 
This table supports the procurement and inventory management process by mapping specific product variants—defined by their attribute values (e.g., color, size, material)—to the individual lines of a purchase order. It ensures that when a purchase order is generated, the specific configuration of the product being ordered is preserved and linked correctly to the order line.

## Description
One row represents a single association between a specific product attribute value and a purchase order line. This is a raw landing of an Odoo join table, serving as a bridge to resolve many-to-many relationships between product configurations and procurement documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the primary purchase order line record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific product variant attribute selected. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `purchase_order_line_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `purchase_order_line_id` → `purchase_order_line.id` (Inferred from Odoo naming conventions).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of `purchase_order_line_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes of its own.
- Expect high cardinality in both columns as this represents a many-to-many relationship.
- There is no audit timestamp or soft-delete flag present in this table; state changes are typically handled by the source system's transactional logic.
- Ensure joins to parent tables are handled as inner joins if you only require records with valid associations.