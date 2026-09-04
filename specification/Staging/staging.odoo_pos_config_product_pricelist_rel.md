# odoo_pos_config_product_pricelist_rel

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `_rel` and the presence of `pos_config_id` and `product_pricelist_id` are characteristic of Odoo's many-to-many relationship tables, which are used to link POS configurations to available product pricelists.

## Functional process 
This table supports the POS configuration and pricing management process. It defines the mapping between specific Point of Sale instances and the pricelists they are authorized to use, ensuring that cashiers can select the correct pricing strategy for a given store or terminal.

## Description
One row in this table represents a single association between a POS configuration and a product pricelist. It serves as a raw, junction-table copy from the Odoo database, facilitating the many-to-many relationship required to allow a single POS terminal to access multiple pricing tiers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary key of the `pos_config` table. |
| product_pricelist_id | INTEGER | false | Foreign key to the product pricelist | Links to the primary key of the `product_pricelist` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of `(pos_config_id, product_pricelist_id)`.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the configuration record for a specific POS terminal.
    - `product_pricelist_id` → `product_pricelist.id`: This column references the specific pricelist available to the POS.
- **Natural keys (inferred):** The combination of `(pos_config_id, product_pricelist_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified based on this table alone.
- Ensure that joins to `pos_config` and `product_pricelist` are handled as inner joins if you only require active, valid relationships.