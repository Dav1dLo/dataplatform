# odoo_ir_demo_failure_wizard

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `ir_demo_failure_wizard` (Odoo's "ir" prefix typically denotes "ir_model" or internal registry tables) and the standard Odoo audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the Odoo internal framework's demonstration data loading process. It acts as a transient state tracker or wizard configuration table used when the system encounters failures during the automated installation or processing of demonstration data modules.

## Description
One row in this table represents a single instance of a demonstration data failure event or a configuration state for a failure-handling wizard. It serves as a raw landed copy of the Odoo internal registry state, capturing the audit trail of who created or modified the wizard record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence value. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the Odoo application layer. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are in place if mapping to human-readable names.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless Odoo-specific logic (not present here) is applied.
- **Data Nature:** As a "wizard" table, this may contain transient data that is cleared or truncated by the Odoo application periodically.