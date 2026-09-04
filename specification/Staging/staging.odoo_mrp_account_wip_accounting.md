# odoo_mrp_account_wip_accounting

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) and Accounting modules. The naming convention `mrp_account_wip_accounting` and the presence of `journal_id` and `reversal_date` are characteristic of Odoo's internal accounting entries generated during manufacturing work-in-progress (WIP) valuation processes.

## Functional process 
This table supports the manufacturing accounting pipeline, specifically tracking the valuation of work-in-progress inventory. It records the accounting entries associated with WIP movements, allowing the system to reconcile manufacturing costs against the general ledger via the referenced journal.

## Description
One row in this table represents a single accounting entry or adjustment related to manufacturing work-in-progress. It serves as a raw landed copy of the Odoo internal accounting record, capturing the timing and reference details of WIP valuation events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.mrp_account_wip_accounting_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Identifies the ledger where this entry is posted. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the internal Odoo user table. |
| reference | VARCHAR | true | Transaction reference string | Often contains document numbers or internal codes. |
| date | DATE | true | Accounting date of the entry | The date the entry is effective in the ledger. |
| reversal_date | DATE | false | Scheduled reversal date | Used for accruals or temporary WIP adjustments. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `staging.account_journal.id` (Guess: standard Odoo pattern for linking accounting entries to journals).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo pattern for audit trails).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `reference` column may contain inconsistent formatting as it is often a free-text field in the source system.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.
- **Precision:** The `VARCHAR` type for `reference` does not specify a length; downstream systems should handle variable-length strings safely.