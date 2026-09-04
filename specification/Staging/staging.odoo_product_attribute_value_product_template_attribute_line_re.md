# odoo_product_attribute_value_product_template_attribute_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `product_attribute_value` and `product_template_attribute_line` is characteristic of Odoo's ORM-generated many-to-many join tables.

## Functional process 
This table supports the product configuration and variant management process. It maps specific attribute values (e.g., "Red", "Large") to the lines that define which attributes are available for a specific product template, enabling the generation of product variants.

## Description
One row represents a single association between a product attribute value and a product template attribute line. This is a raw landing of a many-to-many join table, serving as the link between product definitions and their selectable attribute options.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_value_id | INTEGER | false | Foreign key to the product attribute value definition. | Links to the specific value (e.g., color name or size). |
| product_template_attribute_line_id | INTEGER | false | Foreign key to the product template attribute line. | Links to the line defining the attribute for a template. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(product_attribute_value_id, product_template_attribute_line_id)`.
- **Foreign keys (inferred):** 
    - `product_attribute_value_id` → `product_attribute_value.id` (Inferred from Odoo naming convention).
    - `product_template_attribute_line_id` → `product_template_attribute_line.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of `(product_attribute_value_id, product_template_attribute_line_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality relative to the parent tables.
- No soft-delete flags are present; assume this table reflects the current state of relationships in the source system.
- Ensure joins to parent tables handle potential orphan records if the upstream Odoo instance has referential integrity gaps.