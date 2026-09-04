# odoo_account_fiscal_position_pos_config_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships defined in the underlying PostgreSQL database.

## Functional process 
This table supports the configuration of Point of Sale (POS) systems by mapping fiscal positions to specific POS configurations. It ensures that when a transaction occurs at a specific POS terminal, the correct tax and accounting rules (fiscal positions) are applied based on the business logic defined in the Odoo accounting module.

## Description
One row in this table represents a single association between a Point of Sale configuration and a fiscal position. It serves as a raw landing copy of the many-to-many relationship table used by the Odoo backend to link `pos.config` and `account.fiscal.position` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the `pos_config` table. |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position | Links to the `account_fiscal_position` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo many-to-many tables often lack a surrogate primary key, relying instead on a composite unique index on both columns.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the primary identifier of the POS configuration entity.
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the primary identifier of the fiscal position entity.
- **Natural keys (inferred):** The combination of `(pos_config_id, account_fiscal_position_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no non-key attributes; it is strictly a join table.
- There are no timestamps or audit columns present; incremental loading logic should rely on the source system's `write_date` or `create_date` if available in the parent tables, or perform full refreshes.
- No PII is present in this table.
- As a raw staging table, it reflects the state of the Odoo database at the time of extraction; it does not contain soft-delete flags.