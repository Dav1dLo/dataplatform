# odoo_template_attribute_value_mrp_production_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` indicates a join table used by the Odoo ORM to manage a many-to-many relationship between manufacturing production orders and product template attribute values.

## Functional process 
This table supports the Manufacturing (MRP) module, specifically linking production orders to the specific attribute values (e.g., color, size, or material variants) configured for the products being manufactured. It ensures that the production process tracks the specific variant configuration requested in the manufacturing order.

## Description
One row represents a single association between a manufacturing production order and a specific product template attribute value. It serves as a raw landing copy of the Odoo database's many-to-many link table, facilitating the reconstruction of product configurations within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| production_id | INTEGER | false | Foreign key to the manufacturing production order. | Links to the primary key of the production table. |
| template_attribute_value_id | INTEGER | false | Foreign key to the product template attribute value. | Identifies the specific variant attribute applied to the production. |

## Keys

- **Primary key (inferred):** The combination of `production_id` and `template_attribute_value_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id`: This column references the manufacturing order header.
    - `template_attribute_value_id` → `product_template_attribute_value.id`: This column references the specific attribute value definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between production orders and attribute values.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present; incremental loading must rely on the upstream source's replication logic.
- There are no sensitive PII columns in this table.
- The table contains only integer identifiers; all descriptive attributes must be joined from their respective parent tables.