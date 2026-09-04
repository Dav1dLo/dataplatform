# odoo_res_country_res_country_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_country_res_country_group_rel` is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table between the `res.country` and `res.country.group` models.

## Functional process 
This table supports the management of country groupings within the Odoo platform. It facilitates the association of multiple countries to specific country groups, which are typically used for regional pricing, tax rules, or shipping zone configurations.

## Description
One row in this table represents a single association between a specific country and a country group. It serves as a raw junction table in the staging layer, maintaining the many-to-many relationship between the two entities as landed from the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_country_id | INTEGER | false | Foreign key to the country record | Links to the primary key of the `res_country` table. |
| res_country_group_id | INTEGER | false | Foreign key to the country group record | Links to the primary key of the `res_country_group` table. |

## Keys

- **Primary key (inferred):** The composite key `(res_country_id, res_country_group_id)`.
- **Foreign keys (inferred):** 
    - `res_country_id` → `res_country.id`: This column references the country entity.
    - `res_country_group_id` → `res_country_group.id`: This column references the country group entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- Ensure joins are performed on both columns to maintain the integrity of the relationship, as neither column is unique on its own.