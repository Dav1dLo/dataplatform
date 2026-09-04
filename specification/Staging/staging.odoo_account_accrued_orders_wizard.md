# odoo_account_accrued_orders_wizard

## Source system
This table originates from Odoo ERP. The naming convention `odoo_account_accrued_orders_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) strongly indicate this is a direct landing of an Odoo transient model used for the Accrued Orders wizard process.

## Functional process 
This table supports the financial accounting process for managing accrued orders, specifically the wizard used to generate accrual entries for purchase orders that have been received but not yet invoiced. It captures the configuration and parameters (such as the target journal, account, and dates) required to calculate and post these accruals.

## Description
One row represents a single execution or draft state of the Accrued Orders wizard within the Odoo accounting module. As a staging table, it serves as a raw, transient copy of the wizard's state before the data is processed into permanent accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_accrued_orders_wizard_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the legal entity for the accrual. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | The journal where the accrual entry will be recorded. |
| currency_id | INTEGER | true | Foreign key to the currency | The currency in which the accrual amount is denominated. |
| account_id | INTEGER | false | Foreign key to the general ledger account | The target account for the accrual entry. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user ID. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo user ID. |
| date | DATE | false | Accrual date | The accounting date for the accrual entry. |
| reversal_date | DATE | false | Reversal date | The date on which the accrual entry should be reversed. |
| amount | NUMERIC | true | Accrual amount | The total value to be accrued. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern)
    - `journal_id` → `account_journal.id` (Standard Odoo pattern)
    - `currency_id` → `res_currency.id` (Standard Odoo pattern)
    - `account_id` → `account_account.id` (Standard Odoo pattern)
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo pattern)
- **Natural keys (inferred):** Not confidently inferable; this is a transient wizard table and may not have a unique business key.

## Caveats for downstream consumers

- **Transient Data:** As a "wizard" table, rows may be ephemeral or represent draft states that are deleted or overwritten after the accrual process is finalized in the source system.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Precision:** The `amount` column is `NUMERIC` without defined scale/precision; verify if downstream systems require explicit casting to `NUMERIC(16,2)` or similar for financial reporting.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume this table reflects the current state of the wizard as landed from the source.