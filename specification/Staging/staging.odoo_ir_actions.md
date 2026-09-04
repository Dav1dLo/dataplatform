# odoo_ir_actions

## Source system
This table originates from Odoo ERP, specifically the `ir_actions` table within the Odoo framework's metadata schema. The presence of columns like `create_uid`, `write_uid`, and `JSONB` fields for translatable strings (`name`, `help`) is characteristic of Odoo's internal object-relational mapping (ORM) system.

## Functional process 
This table supports the Odoo application's action framework, which defines how the system responds to user interactions (e.g., opening a view, executing a server action, or running a report). It acts as the registry for all available actions within the ERP, linking UI elements to specific models and execution logic.

## Description
One row in this table represents a single action definition within the Odoo environment, such as a window action, report action, or server action. As a staging table, it provides a raw, landed copy of the Odoo `ir_actions` metadata, capturing the configuration and audit history for system-level actions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; default uses `staging.ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model | References the model this action is bound to. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this action record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this action record. |
| type | VARCHAR | false | Action type | Defines the category of action (e.g., `ir.actions.act_window`). |
| path | VARCHAR | true | URL path | Used for specific action types requiring a web path. |
| binding_type | VARCHAR | false | Binding category | Defines how the action is bound to the UI (e.g., 'action', 'report'). |
| binding_view_types | VARCHAR | true | View types | Comma-separated list of view types where this action is available. |
| name | JSONB | false | Action label | Translatable name of the action; stored as JSONB for multi-language support. |
| help | JSONB | true | Action description | Translatable help text for the action; stored as JSONB. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id` (Guess: links the action to a specific Odoo data model).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the user table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the user table).
- **Natural keys (inferred):** Not confidently inferable. While `name` exists, Odoo actions are often identified by their `xml_id` (external identifier), which is not present in this table.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `help` columns contain JSONB data. Query writers must use PostgreSQL JSONB operators (e.g., `->>`) to extract specific language values (e.g., `name->>'en_US'`).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage standard.
- **Data Integrity:** This is a raw staging table; it may contain system-generated actions that are not relevant for business reporting. Filter by `type` as needed.
- **Soft Deletes:** Odoo typically performs hard deletes on metadata tables; assume no soft-delete flag exists unless `active` is present (which is absent here).