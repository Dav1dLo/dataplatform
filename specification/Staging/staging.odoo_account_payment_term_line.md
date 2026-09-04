# odoo_account_payment_term_line

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_account_payment_term_line`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Accounts Receivable/Payable configuration process, specifically defining the breakdown of payment terms. It dictates how a total invoice amount is split into installments or percentages over a specific timeline (e.g., "30% due immediately, 70% due in 30 days").

## Description
One row represents a single line item within a payment term definition, specifying a portion of an invoice amount and its associated due date calculation logic. This is a raw landing table in the staging layer, capturing the configuration state of payment terms as defined in the Odoo backend.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| nb_days | INTEGER | true | Number of days for the payment term | Used when `delay_type` involves a day offset. |
| payment_id | INTEGER | false | Foreign key to the parent payment term | Links to the header record. |
| create_uid | INTEGER | true | User ID who created the record | Reference to Odoo res_users. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to Odoo res_users. |
| value | VARCHAR | false | Type of value calculation | e.g., 'percent', 'fixed', 'balance'. |
| delay_type | VARCHAR | false | Method for calculating the due date | e.g., 'days_after_invoice', 'fix_day_of_month'. |
| days_next_month | VARCHAR(2) | true | Specific day of the next month | Used if `delay_type` is 'fix_day_of_month'. |
| value_amount | NUMERIC | true | The amount or percentage value | Interpretation depends on the `value` column. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `staging.odoo_account_payment_term.id`: This column links the line item to its parent payment term definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's standard database storage.
- **Data Interpretation:** The `value_amount` column is polymorphic; its meaning (percentage vs. absolute currency amount) is strictly governed by the `value` column.
- **Soft Deletes:** This table does not appear to contain a soft-delete flag (e.g., `active` or `is_deleted`); assume all records are current unless Odoo's internal logic dictates otherwise.
- **Precision:** `value_amount` and `value` columns should be cast carefully in downstream models to ensure financial accuracy.