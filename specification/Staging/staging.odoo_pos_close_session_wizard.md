# odoo_pos_close_session_wizard

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `odoo_pos_...` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the POS session management process, specifically the "Close Session" wizard functionality. It captures the state and user input required when a cashier or manager attempts to reconcile and close a POS session, including any balance discrepancies and associated messages.

## Description
One row in this table represents a single instance of a POS session closure wizard execution. It acts as a transient staging record used to facilitate the reconciliation logic before the session is officially marked as closed in the core POS module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| account_id | INTEGER | true | Foreign key to the accounting ledger | Links to the account used for balancing the session. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard record. |
| message | TEXT | true | Closure notes | Optional text provided during the session closure process. |
| account_readonly | BOOLEAN | true | Read-only flag for account | Indicates if the account selection is locked for editing. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; Odoo standard audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC; Odoo standard audit field. |
| amount_to_balance | DOUBLE PRECISION | true | Reconciliation amount | The monetary value required to balance the session. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account_account.id` (Guess: links to the chart of accounts).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; verify against system configuration if local time conversion is required.
- **Data Retention:** As a wizard/transient table, records may be purged or overwritten by the Odoo application logic; do not treat this as a permanent audit log of closed sessions.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to PII in the `res_users` table.
- **Precision:** `amount_to_balance` uses `DOUBLE PRECISION`; be aware of potential floating-point rounding issues when performing financial aggregations.