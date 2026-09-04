# odoo_product_tag_product_product_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_product_tag_product_product_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link two entities (in this case, products and product tags) via a join table.

## Functional process 
This table supports the product categorization and tagging process within the Odoo inventory or e-commerce module. It enables the many-to-many relationship between individual product records and their associated descriptive tags, allowing a single product to carry multiple tags and a single tag to be applied to multiple products.

## Description
One row in this table represents a single association between a specific product and a specific product tag. It serves as a raw, landed join table in the staging layer, maintaining the link between the product master data and the tag taxonomy.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key to the product record | References the primary key of the product table. |
| product_tag_id | INTEGER | false | Foreign key to the product tag record | References the primary key of the product tag definition table. |

## Keys

- **Primary key (inferred):** The composite key `(product_product_id, product_tag_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `product_product_id` → `product_product.id`: This column links to the product master table.
    - `product_tag_id` → `product_tag.id`: This column links to the tag definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to the parent tables (`product_product` and `product_tag`) handle potential orphans if the source system's referential integrity is not strictly enforced during extraction.