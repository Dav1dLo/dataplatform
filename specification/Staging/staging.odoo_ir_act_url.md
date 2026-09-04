# odoo_ir_act_url

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `ir_act_url` corresponds to Odoo's internal "IrActionsUrl" model, which stores URL-based action definitions used within the Odoo framework to trigger web-based navigation or external links from the user interface.

## Functional process 
This table supports the Odoo application's navigation and action-handling framework. It defines URL actions that appear in the system's menus or views, allowing the application to redirect users to specific internal or external web resources when triggered by a UI event.

## Description
One row in this table represents a single URL-based action configuration within the Odoo environment. It acts as a raw landing copy of the system's action registry, capturing the metadata required to render and execute a URL redirection. The grain is one row per unique URL action definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Links to `ir_model` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users` table. |
| type | VARCHAR | false | Action type identifier | Typically 'ir.actions.act_url'. |
| path | VARCHAR | true | URL path segment | Optional path override. |
| binding_type | VARCHAR | false | Type of binding | Defines how the action is attached to a model. |
| binding_view_types | VARCHAR | true | View types for binding | Comma-separated list of view types (e.g., 'list,form'). |
| name | JSONB | false | Display name of the action | Multilingual JSON object. |
| help | JSONB | true | Help tooltip text | Multilingual JSON object. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| target | VARCHAR | false | Target window for the URL | Values like 'new' or 'self'. |
| url | TEXT | false | The destination URL | The actual link to be opened. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `staging.odoo_ir_model.id` (Inferred from Odoo naming conventions for model bindings).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo audit trail pattern).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable; Odoo actions are typically managed via the `id` surrogate.

## Caveats for downstream consumers

- **JSONB content:** The `name` and `help` columns contain JSONB data, likely representing Odoo's translation dictionary (e.g., `{"en_US": "My Action", "fr_FR": "Mon Action"}`). You will need to extract specific keys or use `->>` operators to access values.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data volatility:** As a staging table for Odoo metadata, this table may contain system-generated records that change frequently during Odoo module upgrades or configuration updates.
- **Soft deletes:** Odoo does not typically use soft-delete flags in `ir_` tables; records are usually physically deleted.