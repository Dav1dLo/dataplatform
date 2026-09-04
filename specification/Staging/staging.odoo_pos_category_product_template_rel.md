# odoo_pos_category_product_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the pairing of `product_template_id` with `pos_category_id` are characteristic of Odoo's internal many-to-many relationship tables used to link product templates to Point of Sale (POS) categories.

## Functional process 
This table supports the Point of Sale (POS) product catalog management process. It defines the many-to-many mapping between product templates and POS categories, allowing a single product to be associated with multiple POS categories or a category to contain multiple products for display in the POS interface.

## Description
One row in this table represents a single association between a product template and a POS category. It serves as a raw landing copy of the Odoo join table, facilitating the reconstruction of product-to-category hierarchies in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | References the primary product definition. |
| pos_category_id | INTEGER | false | Foreign key to the POS category | References the category structure used in the POS module. |

## Keys

- **Primary key (inferred):** The combination of `(product_template_id, pos_category_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: Links to the core product definition.
    - `pos_category_id` → `pos_category.id`: Links to the POS category definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the history of these associations from this table alone.
- Ensure joins to `product_template` and `pos_category` are handled as inner joins if you only require active associations, or left joins if you are auditing orphaned relationships.