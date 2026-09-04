# odoo_ir_act_window

## Source system
This table originates from Odoo ERP, specifically the `ir.act.window` model within the Odoo framework's metadata layer. The naming convention `ir_act_window` (Internal Resource Action Window) is a standard Odoo pattern used to define client-side window actions that trigger views, forms, or search filters in the user interface.

## Functional process 
This table supports the UI/UX configuration and navigation process within the Odoo platform. It defines how specific models (`res_model`) are presented to users, including which views (`view_mode`) to load, the default search filters (`domain`), and the target display behavior (e.g., current window, new tab, or popup).

## Description
One row represents a single window action configuration that dictates how a specific Odoo resource or model is rendered in the web client. It acts as a raw landing copy of the Odoo system's action registry, capturing the metadata required to bridge database models to front-end interface components.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Links to `ir_model`. |
| create_uid | INTEGER | true | ID of the user who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Links to `res_users`. |
| type | VARCHAR | false | The action type identifier | Usually 'ir.actions.act_window'. |
| path | VARCHAR | true | URL path associated with the action | Often null for standard model actions. |
| binding_type | VARCHAR | false | Type of binding (e.g., 'action', 'report') | Determines how the action appears in menus. |
| binding_view_types | VARCHAR | true | Comma-separated list of view types | Defines where the action is available. |
| name | JSONB | false | Display name of the action | Odoo uses JSONB for multi-language support. |
| help | JSONB | true | Help text displayed in empty views | Multi-language support via JSONB. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| view_id | INTEGER | true | Default view ID | Links to `ir_ui_view`. |
| res_id | INTEGER | true | Specific resource ID | Used if the action opens a specific record. |
| limit | INTEGER | true | Default number of records per page | Controls pagination in list views. |
| search_view_id | INTEGER | true | ID of the search view | Links to `ir_ui_view`. |
| domain | VARCHAR | true | Filter criteria for the action | Python-style domain expression. |
| context | VARCHAR | false | Context dictionary for the action | Passed to the client/server as a string. |
| res_model | VARCHAR | false | The target model name | The technical name of the Odoo model. |
| target | VARCHAR | true | Target display window | e.g., 'current', 'new', 'inline'. |
| view_mode | VARCHAR | false | Comma-separated list of view modes | e.g., 'tree,form'. |
| mobile_view_mode | VARCHAR | true | View modes specific to mobile | Overrides `view_mode` on mobile devices. |
| usage | VARCHAR | true | Usage category | Used for internal Odoo routing. |
| filter | BOOLEAN | true | Whether the action is a filter | Indicates if this is a saved search filter. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field)
    - `write_uid` → `res_users.id` (Standard Odoo audit field)
    - `view_id` → `ir_ui_view.id` (Links to view definition)
    - `search_view_id` → `ir_ui_view.id` (Links to search view definition)
- **Natural keys (inferred):** Not confidently inferable; Odoo actions are typically identified by their `xml_id` (stored in `ir_model_data`), which is not present in this table.

## Caveats for downstream consumers

- **JSONB columns:** `name` and `help` contain localized strings; ensure your query logic handles JSONB extraction (e.g., `name->>'en_US'`).
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo server configurations.
- **Soft deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.
- **Domain/Context:** The `domain` and `context` columns contain serialized Python strings; these are not directly executable in SQL and require parsing if used for filtering.