# odoo_wizard_ir_model_menu_create

## Source system
This table originates from Odoo ERP. The naming convention `ir_model_menu_create` is characteristic of Odoo's internal registry (IR) tables, specifically those associated with transient wizard models used to generate menu items for custom models within the Odoo framework.

## Functional process 
This table supports the "Menu Creation Wizard" process within the Odoo application. It tracks the state of transient wizard sessions used by administrators or developers to dynamically generate menu entries for specific data models, capturing the metadata required to link these menus to the underlying system architecture.

## Description
One row in this table represents a single execution instance of the menu creation wizard. It acts as a raw landing copy of the transient wizard state, capturing the name of the menu to be created and the audit trail of the user who initiated or modified the wizard session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.wizard_ir_model_menu_create_id_seq`. |
| menu_id | INTEGER | false | Foreign key to the target menu | References the ID of the menu being managed or created. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the wizard record. |
| name | VARCHAR | false | Menu name | The display name assigned to the menu being created. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard session was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard session was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id` (guess: standard Odoo pattern for linking wizard records to menu definitions).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to resolve PII (names/emails).
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against system configuration if local time is required.
- **Data Lifecycle:** As a "wizard" table, rows may be transient and subject to periodic cleanup or truncation by the Odoo framework.
- **Precision:** `VARCHAR` length is not explicitly defined in the source DDL; assume standard Odoo string handling (often 255 or unlimited).