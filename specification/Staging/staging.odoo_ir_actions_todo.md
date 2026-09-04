# odoo_ir_actions_todo

## Source system
This table originates from Odoo ERP, specifically the `ir_actions_todo` model within the Odoo framework's internal registry. The naming convention `ir_` (Internal Registry) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's metadata-driven architecture.

## Functional process 
This table supports the "Action Todo" business process, which manages tasks or configuration steps that need to be completed by users, often triggered during module installation or system setup. It tracks the sequence and state of these pending actions, ensuring that administrative or configuration workflows are executed in the correct order.

## Description
One row in this table represents a single "todo" action item that requires user attention or system processing. It serves as a raw landed copy of the Odoo internal registry table, capturing the state, sequence, and audit trail for each action item. The grain is one row per action definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_actions_todo_id_seq`. |
| action_id | INTEGER | false | Reference to the specific action definition | Likely links to `ir_actions` table. |
| sequence | INTEGER | true | Execution order priority | Lower numbers typically indicate higher priority. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users` table. |
| state | VARCHAR | false | Current status of the action | e.g., 'open', 'done'. |
| name | VARCHAR | true | Descriptive name of the action | Human-readable label. |
| create_date | TIMESTAMP | true | Creation timestamp | Timezone is typically UTC in Odoo. |
| write_date | TIMESTAMP | true | Last modification timestamp | Timezone is typically UTC in Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for creator).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for modifier).
    - `action_id` → `ir_actions.id` (Likely reference to the base action definition).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores timestamps in UTC; ensure your downstream transformations account for this if local time conversion is required.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records, which may contain PII; ensure appropriate access controls are applied when joining with user tables.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are current unless otherwise specified by Odoo's internal logic.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source DDL; assume standard Odoo string lengths (often 255 or unlimited) and monitor for truncation if mapping to fixed-width targets.