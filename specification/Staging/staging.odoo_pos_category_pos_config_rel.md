# odoo_pos_category_pos_config_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between two business entities.

## Functional process 
This table supports the Point of Sale (POS) configuration process. It manages the many-to-many relationship between POS configurations and product categories, determining which product categories are available or enabled for selection within specific POS terminal interfaces.

## Description
One row represents a single association between a specific POS configuration and a product category. It serves as a raw landing copy of the Odoo database link table, facilitating the mapping of category visibility across different POS setups.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | References the primary key of the POS configuration table. |
| pos_category_id | INTEGER | false | Foreign key to the POS category | References the primary key of the POS category table. |

## Keys

- **Primary key (inferred):** The composite key `(pos_config_id, pos_category_id)` is the inferred primary key, as this is a standard Odoo many-to-many link table.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: Links to the configuration definition.
    - `pos_category_id` → `pos_category.id`: Links to the category definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic must rely on full refreshes or source-side Odoo `write_date` tracking if available in the parent tables.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.