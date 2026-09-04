# odoo_mrp_account_wip_accounting_line

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) and Accounting modules. The naming convention `mrp_account_wip_accounting_line` and the presence of columns like `wip_accounting_id`, `debit`, and `credit` are characteristic of Odoo's internal accounting ledger structures for tracking Work-in-Progress (WIP) costs during manufacturing processes.

## Functional process 
This table supports the manufacturing cost accounting process, specifically tracking the financial impact of WIP movements. It records individual accounting line entries associated with WIP accounting records, allowing the system to reconcile manufacturing consumption and production costs against the general ledger.

## Description
One row in this table represents a single accounting line entry associated with a Work-in-Progress (WIP) accounting record. It acts as a raw landing copy of the Odoo database table, capturing the financial details (debit/credit) and audit metadata for manufacturing-related accounting transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| account_id | INTEGER | true | Foreign key to the general ledger account | Links to the chart of accounts. |
| currency_id | INTEGER | true | Foreign key to the currency table | Defines the currency for the transaction. |
| wip_accounting_id | INTEGER | true | Foreign key to the parent WIP accounting record | Links to the header record for this WIP entry. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| label | VARCHAR | true | Descriptive label for the accounting line | Often contains transaction descriptions. |
| debit | NUMERIC | true | Debit amount | Monetary value in the transaction currency. |
| credit | NUMERIC | true | Credit amount | Monetary value in the transaction currency. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.account.id` (guess based on standard Odoo schema)
    - `currency_id` → `res.currency.id` (guess based on standard Odoo schema)
    - `wip_accounting_id` → `mrp.account.wip.accounting.id` (guess based on table name)
    - `create_uid` / `write_uid` → `res.users.id` (standard Odoo audit pattern)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains financial transaction data; ensure access is restricted according to organizational policy.
- **Timestamps:** Timestamps are stored in the Odoo server's local time; verify the server timezone configuration to ensure accurate conversion to UTC.
- **Data Integrity:** As a staging table, this is a raw dump; expect potential nulls in foreign key fields if the parent records were deleted or not synced.
- **Precision:** `NUMERIC` types do not specify scale/precision in the metadata; assume standard Odoo financial precision (usually 2 decimal places) but validate against source samples.