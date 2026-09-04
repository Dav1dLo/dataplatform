# odoo_theme_ir_ui_view

## Source system
This table originates from the Odoo ERP system, specifically the `ir.ui.view` model which manages the user interface architecture. The presence of columns like `arch`, `arch_fs`, and `inherit_id` is characteristic of Odoo's view inheritance and XML-based UI definition engine.

## Functional process 
This table supports the Odoo UI customization and theme management process. It stores the structural definitions (XML/JSON) for views, allowing the system to render dynamic web pages and backend forms by inheriting from base views and applying modifications based on the `priority` and `mode` settings.

## Description
One row in this table represents a single UI view definition or a customization layer applied to an existing view within the Odoo framework. It serves as a raw landing copy of the system's view registry, capturing the structural metadata, inheritance hierarchy, and active status of interface components.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| priority | INTEGER | false | Rendering order | Lower numbers indicate higher priority in inheritance chains. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the view. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the view. |
| name | VARCHAR | false | View name | Descriptive label for the UI component. |
| key | VARCHAR | true | Unique view key | Often used for programmatic lookup of specific views. |
| type | VARCHAR | true | View type | e.g., 'tree', 'form', 'qweb', 'kanban'. |
| mode | VARCHAR | true | Inheritance mode | Indicates if the view is 'primary' or 'extension'. |
| arch_fs | VARCHAR | true | File system path | Path to the source XML file if defined on disk. |
| inherit_id | VARCHAR | true | Parent view ID | Reference to the view being extended. |
| arch | JSONB | true | View architecture | The actual XML/JSON structure defining the UI. |
| active | BOOLEAN | true | Active status | Soft-delete flag; if false, the view is ignored by the engine. |
| customize_show | BOOLEAN | true | Customization visibility | Flag for UI-level visibility of customization options. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `inherit_id` → `ir_ui_view.id` (guess: self-referencing hierarchy for view inheritance).
- **Natural keys (inferred):** 
    - `key` (if populated, this is typically the unique business identifier for a view).

## Caveats for downstream consumers

- **Sensitive Data:** None identified, though `arch` may contain references to internal system paths or logic.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless auditing historical UI states.
- **JSONB Content:** The `arch` column contains complex nested structures; downstream consumers will need to use PostgreSQL JSONB operators (e.g., `->>`, `@>`) to extract specific UI attributes.
- **Data Types:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo defaults (often 255 characters) but verify if truncations occur during ingestion.