# odoo_product_combo_product_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of `_id` foreign key references are characteristic of Odoo's automated many-to-many relationship tables, which are generated to link product templates to product combos.

## Functional process 
This table supports the product catalog and configuration management process. It defines the many-to-many association between product templates (the base product definitions) and product combos (groupings of products often used in point-of-sale or e-commerce bundles).

## Description
One row in this table represents a single association between a specific product template and a product combo. It serves as a raw landing copy of the Odoo join table, facilitating the reconstruction of product bundles or menu configurations in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | References the primary product definition. |
| product_combo_id | INTEGER | false | Foreign key to the product combo | References the bundle or combo grouping. |

## Keys

- **Primary key (inferred):** The combination of `(product_template_id, product_combo_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: This column links to the master product template record.
    - `product_combo_id` → `product_combo.id`: This column links to the master product combo record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect no non-key attributes.
- There is no audit timestamp or soft-delete flag present; this represents the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphans if the source Odoo instance has referential integrity gaps.