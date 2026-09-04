# odoo_res_country_group_pricelist_rel

## Source system
This table originates from Odoo ERP, specifically representing a many-to-many relationship mapping between country groups and pricelists. The naming convention `res_country_group_pricelist_rel` is a standard pattern used by the Odoo ORM to manage join tables for relational fields.

## Functional process 
This table supports the pricing and localization business process by defining which country groups are eligible for specific pricelists. It is used to enforce regional pricing strategies, ensuring that customers belonging to a specific country group are presented with the correct currency and price list during the checkout or quotation process.

## Description
One row in this table represents a single association between a specific pricelist and a country group. It serves as a raw landing copy of the Odoo relational join table, facilitating the reconstruction of many-to-many relationships in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pricelist_id | INTEGER | false | Foreign key to the pricelist definition | Links to the primary key of the `product_pricelist` table. |
| res_country_group_id | INTEGER | false | Foreign key to the country group definition | Links to the primary key of the `res_country_group` table. |

## Keys

- **Primary key (inferred):** The combination of `(pricelist_id, res_country_group_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `pricelist_id → product_pricelist.id`: This column references the master pricelist record.
    - `res_country_group_id → res_country_group.id`: This column references the master country group record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on source-side Odoo `write_date` or `create_date` if available in related tables, or perform full refreshes.
- Ensure that joins to this table are handled as composite keys to avoid fan-out issues.