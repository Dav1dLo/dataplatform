# odoo_account_full_reconcile

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention `account_full_reconcile` and the presence of audit columns like `create_uid` and `write_uid` are characteristic of Odoo's internal ORM structure for tracking full reconciliation events between journal items.

## Functional process 
This table supports the financial reconciliation process, specifically tracking "full" reconciliations where a set of journal items (debits and credits) are fully balanced and closed out. It acts as a header record for reconciliation events, linking the exchange rate movements generated during the process to the specific audit trail of who created or modified the reconciliation.

## Description
One row represents a single full reconciliation event within the Odoo accounting system. It serves as a raw landed copy of the reconciliation header record, capturing the metadata and audit information required to trace when and by whom a set of financial transactions was reconciled.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the reconciliation record. |
| exchange_move_id | INTEGER | true | Foreign key to account_move | Links to the journal entry created to record exchange rate differences. |
| create_uid | INTEGER | true | User ID of creator | References the user who performed the reconciliation. |
| write_uid | INTEGER | true | User ID of last modifier | References the user who last updated the reconciliation record. |
| create_date | TIMESTAMP | true | Creation timestamp | The date and time the reconciliation was created. |
| write_date | TIMESTAMP | true | Last update timestamp | The date and time the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `exchange_move_id` → `account_move.id`: This column typically references the journal entry generated to balance currency exchange differences during reconciliation.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who created the record.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; verify against the source application configuration.
- **Data Sensitivity:** Contains `create_uid` and `write_uid`, which link to internal user IDs; ensure these are joined against the appropriate user dimension for reporting.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by Odoo's internal logic.
- **Audit Columns:** `create_date` and `write_date` are standard Odoo audit fields and should be used for incremental loading strategies.