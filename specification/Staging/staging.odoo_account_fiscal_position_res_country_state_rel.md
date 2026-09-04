# odoo_account_fiscal_position_res_country_state_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `account_fiscal_position` and `res_country_state` is characteristic of Odoo's internal many-to-many relationship tables, which link fiscal positions (tax mapping rules) to specific geographic states.

## Functional process 
This table supports the tax configuration and localization process. It defines the scope of fiscal positions by mapping them to specific states within a country, ensuring that the correct tax rules are applied based on the customer's or company's location.

## Description
One row in this table represents a single association between a fiscal position and a geographic state. It serves as a raw landing copy of the Odoo join table, facilitating the resolution of tax rules based on regional requirements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position definition. | Links to the primary key of the fiscal position table. |
| res_country_state_id | INTEGER | false | Foreign key to the geographic state definition. | Links to the primary key of the country state table. |

## Keys

- **Primary key (inferred):** The combination of `account_fiscal_position_id` and `res_country_state_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the parent fiscal position configuration.
    - `res_country_state_id` → `res_country_state.id`: This column references the specific state record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.