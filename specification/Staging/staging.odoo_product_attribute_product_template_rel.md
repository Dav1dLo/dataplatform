# odoo_product_attribute_product_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `product_attribute_product_template_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link product attributes (e.g., color, size) to product templates (the base product definition).

## Functional process 
This table supports the product catalog management process. It defines the association between product templates and the specific attributes available for those products, enabling the configuration of product variants within the Odoo inventory and sales modules.

## Description
One row in this table represents a single association between a product template and a product attribute. It serves as a raw junction table in the staging layer, capturing the many-to-many relationship required to map which attributes are applicable to which product templates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_id | INTEGER | false | Foreign key to the product attribute definition. | Links to the primary key of the product attribute table. |
| product_template_id | INTEGER | false | Foreign key to the product template definition. | Links to the primary key of the product template table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. While this is a junction table, the provided metadata does not explicitly define a composite primary key; it is likely a composite of `(product_attribute_id, product_template_id)`.
- **Foreign keys (inferred):** 
    - `product_attribute_id` → `product_attribute.id`: This column references the master list of available product attributes.
    - `product_template_id` → `product_template.id`: This column references the master list of product templates.
- **Natural keys (inferred):** The combination of `(product_attribute_id, product_template_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive data other than the foreign keys.
- There are no timestamps or audit columns present in this staging table; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.