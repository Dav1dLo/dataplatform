# odoo_product_optional_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal implementation of many-to-many relationship tables, which are used to link records across different modules or within the product catalog.

## Functional process 
This table supports the product configuration and cross-selling process. It defines the relationship between primary products and their optional products, which are typically presented to customers during the checkout or quotation process to encourage upselling or complementary purchases.

## Description
One row in this table represents a single link between a primary product and an optional product. It acts as a join table for a many-to-many relationship, mapping the `src_id` (the parent product) to the `dest_id` (the optional product). As a staging table, it provides a raw, unjoined view of these associations as extracted directly from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| src_id | INTEGER | false | ID of the primary product | References the product table. |
| dest_id | INTEGER | false | ID of the optional product | References the product table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key on `(src_id, dest_id)`.
- **Foreign keys (inferred):** 
    - `src_id` → `product_product.id` (guess: represents the parent product).
    - `dest_id` → `product_product.id` (guess: represents the optional product).
- **Natural keys (inferred):** The combination of `(src_id, dest_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only surrogate keys; it must be joined with the product master table to retrieve meaningful product names or SKUs.
- The table structure implies a many-to-many relationship; ensure joins are handled carefully to avoid fan-out issues if joining to multiple attributes simultaneously.
- There is no audit or timestamp information available in this table; it represents the current state of relationships as of the last extraction.