# odoo_account_move_send_batch_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_move_send_batch_wizard` is characteristic of Odoo's internal wizard models, which are temporary objects used to manage UI-driven workflows—in this case, the batch processing of accounting entries (account moves).

## Functional process 
This table supports the "Record-to-Report" or "Order-to-Cash" accounting process, specifically the batch handling of invoice or journal entry distribution (e.g., emailing or printing multiple invoices at once). It tracks the metadata of the wizard sessions used to trigger these batch operations.

## Description
One row represents a single execution instance of the batch sending wizard within the Odoo accounting module. It serves as a raw landing copy of the wizard's state, tracking who initiated the batch process and when the record was last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_move_send_batch_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the wizard record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the wizard record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely in UTC; verify against Odoo system settings. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely in UTC; verify against Odoo system settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table represents a transient "wizard" state; rows may be ephemeral or cleaned up by Odoo's internal maintenance routines.
- Timestamps are assumed to be in UTC, consistent with standard Odoo database storage practices.
- No PII is present in this specific table, as it only contains audit metadata and user references.
- The table is a raw staging extract; ensure joins to `res_users` are handled as outer joins if user records have been purged or are not present in the staging layer.