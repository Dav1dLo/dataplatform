# odoo_res_currency_rate

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming convention `res_currency_rate` is standard for Odoo's core "Resources" module, which manages multi-currency exchange rates for financial reporting and transaction processing.

## Functional process 
This table supports the multi-currency accounting and financial reporting process. It maintains the historical exchange rate mappings required to convert transaction values from foreign currencies into the base currency of the company, ensuring accurate financial consolidation and ledger balancing.

## Description
One row in this table represents a specific exchange rate for a given currency on a specific date. It serves as a raw landed copy of the Odoo `res_currency_rate` table, capturing the historical rate data used by the ERP to perform currency conversions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_currency_rate_id_seq`. |
| currency_id | INTEGER | false | Foreign key to the currency | References the currency being defined. |
| company_id | INTEGER | true | Foreign key to the company | The company context for this rate; null if global. |
| create_uid | INTEGER | true | User ID who created the record | References the user who initially set the rate. |
| write_uid | INTEGER | true | User ID who last updated the record | References the user who last modified the rate. |
| name | DATE | false | Effective date of the rate | The calendar date for which this exchange rate applies. |
| rate | NUMERIC | true | Exchange rate value | The conversion factor relative to the base currency. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit timestamp from Odoo. |
| write_date | TIMESTAMP | true | Record modification timestamp | Inferred UTC; audit timestamp from Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `staging.res_currency.id` (Guess: standard Odoo relational link to currency definitions).
    - `company_id` → `staging.res_company.id` (Guess: standard Odoo relational link to company entities).
- **Natural keys (inferred):** 
    - `(currency_id, name, company_id)`: In Odoo, a currency rate is typically unique per currency, per date, and per company context.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user IDs; these should be joined against a user dimension to identify specific employees.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `rate` column is `NUMERIC` without defined precision; downstream consumers should cast this to a fixed-point decimal (e.g., `NUMERIC(18, 6)`) to prevent rounding errors during financial calculations.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are current unless Odoo's internal logic dictates otherwise.