# odoo_calendar_popover_delete_wizard

## Source system
This table originates from Odoo ERP. The naming convention `odoo_calendar_popover_delete_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven wizard processes.

## Functional process 
This table supports the "Calendar Event Management" process. It acts as a temporary state holder for the UI wizard that handles the deletion of calendar events or popover entries within the Odoo calendar module, allowing users to confirm or configure deletion parameters before the action is committed to the main calendar tables.

## Description
One row in this table represents a single instance of a calendar deletion wizard session initiated by a user. It is a transient staging entity used to capture user input during the deletion workflow. This table serves as a raw landed copy of the Odoo transient model state.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `calendar_popover_delete_wizard_id_seq`. |
| record | INTEGER | true | ID of the target calendar record | Likely a foreign key to the main calendar event table. |
| create_uid | INTEGER | true | User ID who created the wizard session | Reference to the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the wizard session | Reference to the Odoo `res.users` table. |
| delete | VARCHAR | true | Deletion configuration flag or mode | Likely stores the scope of deletion (e.g., 'this', 'all', 'future'). |
| create_date | TIMESTAMP | true | Timestamp of wizard creation | UTC assumed based on Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last wizard update | UTC assumed based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `record` → `calendar_event.id` (Guess: links the wizard to the specific event being deleted).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Transient Data:** As a "wizard" table, this data is often ephemeral and may be cleared by Odoo's internal vacuum processes; do not rely on this for long-term audit trails.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user metadata tables for reporting.
- **Soft Deletes:** This table does not implement soft deletes; it represents the state of a UI interaction.