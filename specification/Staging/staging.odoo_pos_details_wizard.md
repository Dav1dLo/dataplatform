# odoo_pos_details_wizard

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `pos_details_wizard` is characteristic of Odoo's transient models (wizards) used to capture user input for generating reports or performing batch actions within the POS interface.

## Functional process 
This table supports the POS reporting process, specifically the generation of "POS Details" reports. It acts as a temporary storage mechanism for the parameters (date ranges) selected by a user when they trigger a report request from the Odoo backend.

## Description
One row in this table represents a single instance of a POS report configuration request initiated by a user. It captures the temporal boundaries (`start_date` and `end_date`) required to filter POS transactions for a specific report. As a staging table, it represents a raw, landed copy of the wizard's state from the Odoo PostgreSQL database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.pos_details_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| start_date | TIMESTAMP | false | Report start date/time | The beginning of the period for the POS report. |
| end_date | TIMESTAMP | false | Report end date/time | The end of the period for the POS report. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC, as per standard Odoo behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC, as per standard Odoo behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable. Wizard tables in Odoo are often transient and lack a unique business key beyond the surrogate ID.

## Caveats for downstream consumers

- **PII/Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee names in other tables.
- **Timezone:** Timestamps are typically stored in UTC by Odoo; verify against the source system configuration if local time offsets are required.
- **Data Lifecycle:** As a "wizard" table, rows may be transient or subject to frequent deletion/cleanup depending on the Odoo `_transient_max_hours` configuration.
- **Usage:** This table is likely a transient staging area; do not rely on it for long-term historical auditing of POS transactions.