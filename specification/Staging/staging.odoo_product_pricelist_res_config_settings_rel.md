# odoo_product_pricelist_res_config_settings_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific column names `res_config_settings_id` and `product_pricelist_id` is characteristic of Odoo's automated many-to-many relationship tables, which link configuration settings to specific product pricelists.

## Functional process 
This table supports the "Product Pricing Configuration" process. It manages the association between system-wide configuration settings (defined in `res_config_settings`) and the specific product pricelists that are enabled or configured within those settings.

## Description
One row in this table represents a single link between a configuration setting record and a product pricelist record. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to map multiple pricelists to specific configuration contexts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_config_settings_id | INTEGER | false | Foreign key to the configuration settings record | Links to the parent configuration entity. |
| product_pricelist_id | INTEGER | false | Foreign key to the product pricelist record | Identifies the specific pricelist associated with the setting. |

## Keys

- **Primary key (inferred):** The composite key `(res_config_settings_id, product_pricelist_id)` is the inferred primary key, as this is a standard Odoo junction table structure.
- **Foreign keys (inferred):** 
    - `res_config_settings_id` → `res_config_settings.id`: This column references the primary configuration settings table.
    - `product_pricelist_id` → `product_pricelist.id`: This column references the master product pricelist table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect no non-key attributes.
- Ensure joins are performed on both columns to maintain referential integrity when querying.
- As a raw staging table, it contains no audit timestamps (e.g., `created_at` or `updated_at`); rely on the parent tables for temporal context.