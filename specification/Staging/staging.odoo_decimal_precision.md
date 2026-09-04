# odoo_decimal_precision

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the use of `nextval` sequences are characteristic of the Odoo framework's ORM layer, which manages metadata for all business objects.

## Functional process 
This table supports the global configuration of numerical precision across the ERP system. It defines how many decimal places should be displayed or stored for various units of measure, currencies, or accounting values, ensuring consistency in calculations throughout the lead-to-cash and procurement pipelines.

## Description
One row in this table represents a specific decimal precision configuration rule, identifying the number of digits allowed for a named business context. As a staging table, it provides a raw, landed copy of the Odoo `decimal.precision` model, serving as the foundation for downstream transformations that enforce rounding logic in financial and inventory reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.decimal_precision_id_seq`. |
| digits | INTEGER | false | Number of decimal places | The precision value to be applied. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| name | VARCHAR | false | Name of the precision context | e.g., 'Account', 'Stock Price', 'Discount'. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `name` (The business name of the precision rule is unique within the Odoo configuration).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Audit columns:** `create_uid` and `write_uid` are internal Odoo user IDs; they will not resolve to meaningful names without joining against the `res_users` staging table.
- **Data volatility:** This table is a configuration table; while it does not change frequently, it is essential for interpreting the scale of numerical values in other Odoo-sourced tables (e.g., `account_move_line` or `stock_move`).
- **Soft deletes:** Odoo typically does not use soft-delete flags in this model; rows are generally hard-deleted or updated in place.