# odoo_account_financial_year_op

## Source system
This table originates from Odoo ERP. The naming convention `odoo_account_financial_year_op` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal PostgreSQL schema structure for financial accounting modules.

## Functional process 
This table supports the financial reporting and accounting period management process. It tracks the configuration and operational status of financial years within the Odoo accounting module, allowing the system to enforce period-based constraints on ledger entries and financial statements.

## Description
One row in this table represents a specific financial year configuration or operational record associated with a company entity. It serves as a raw landed copy of the Odoo source table, capturing the audit trail and linkage to the parent company for financial period management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; default uses `staging.account_financial_year_op_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Links to the organizational entity owning this financial year. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server time (typically UTC). |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server time (typically UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company data isolation).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo server configurations.
- **Audit columns:** `create_date` and `write_date` should be used for incremental loading strategies.
- **Data Integrity:** As a staging table, this may contain raw, unvalidated data; ensure joins to `res_company` or `res_users` account for potential missing references if the source system has orphan records.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in these tables; if a record is missing, it has likely been purged from the source.