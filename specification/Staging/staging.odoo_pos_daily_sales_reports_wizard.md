# odoo_pos_daily_sales_reports_wizard

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `odoo_pos_..._wizard` is characteristic of Odoo's transient models (wizards) used to capture user input for generating reports or performing batch actions within the Odoo web interface.

## Functional process 
This table supports the "POS Reporting" process. It acts as a temporary state container that stores the configuration parameters selected by a user when they trigger a daily sales report generation for a specific POS session.

## Description
One row in this table represents a single configuration instance for a POS daily sales report request. It captures the user's preferences, such as whether to include per-employee breakdowns, linked to a specific POS session. As a staging table, it represents a raw, landed copy of the Odoo wizard state record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.pos_daily_sales_reports_wizard_id_seq`. |
| pos_session_id | INTEGER | false | Foreign key to the POS session | Links the report configuration to a specific POS session. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the report wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the wizard settings. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard record was last modified. |
| add_report_per_employee | BOOLEAN | true | Employee breakdown flag | If true, the generated report includes a breakdown by employee. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_session_id` → `staging.pos_session.id` (Guess: standard Odoo naming convention for linking to session records).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo naming convention for user references).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may map to employee names in the `res_users` table.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database storage practices.
- **Data Lifecycle:** As this is a "wizard" table, rows may be transient or ephemeral; verify if the upstream system performs periodic cleanup of these records.
- **Nullability:** Many fields are nullable, reflecting the optional nature of wizard configurations in the Odoo UI.