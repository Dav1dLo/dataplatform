# odoo_ir_embedded_actions

## Source system
This table originates from Odoo ERP, as indicated by the `ir_` (internal registry) naming convention and the use of `JSONB` for localized fields and `nextval` sequences typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Odoo UI framework's "embedded actions" system, which allows developers to define context-aware actions (such as buttons or menu items) that are dynamically injected into specific views or models. It manages the configuration of these actions, including the associated domain filters, execution methods, and user-specific overrides.

## Description
One row represents a single embedded action configuration linked to a parent resource or model. It acts as a raw landed copy of the Odoo `ir.embedded.actions` model, capturing the metadata required to render and execute custom actions within the Odoo interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.ir_embedded_actions_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort actions in the UI. |
| parent_action_id | INTEGER | false | ID of the parent action | Links to the primary action definition. |
| parent_res_id | INTEGER | true | ID of the specific resource | Null if the action applies to the whole model. |
| action_id | INTEGER | true | ID of the embedded action | Links to the action definition. |
| user_id | INTEGER | true | User ID owner | Restricts the action to a specific user. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| parent_res_model | VARCHAR | false | Technical name of the model | The Odoo model (e.g., 'sale.order') this action belongs to. |
| python_method | VARCHAR | true | Executable method name | The Python function triggered by the action. |
| default_view_mode | VARCHAR | true | Default UI view mode | e.g., 'tree', 'form', 'kanban'. |
| domain | VARCHAR | true | Filter domain | Odoo domain expression for the action. |
| context | VARCHAR | true | Action context | JSON-like string defining the execution context. |
| name | JSONB | true | Display name | Localized name stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_action_id → ir_actions.id` (Guess: links to the base action definition).
    - `user_id → res_users.id` (Guess: links to the system user).
    - `create_uid → res_users.id` (Guess: links to the system user).
    - `write_uid → res_users.id` (Guess: links to the system user).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`user_id`, `create_uid`, `write_uid`) which may need to be joined with `res_users` to identify individuals.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL configurations.
- **Data Format:** The `name` column is `JSONB`; ensure your downstream processing layer can parse JSON objects to extract localized strings.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.