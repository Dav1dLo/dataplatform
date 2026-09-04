# odoo_res_users_deletion

## Source system
This table originates from Odoo ERP, specifically tracking the lifecycle or deletion requests of user records. The naming convention `res_users` is the standard Odoo table for system users, and the `_deletion` suffix indicates a custom or module-specific audit log for user account removal processes.

## Functional process 
This table supports the user lifecycle management and data privacy compliance process. It tracks the status of user deletion requests, likely used to ensure that user accounts marked for removal are processed correctly across the ERP environment.

## Description
One row in this table represents a single user deletion request or audit event. It records the state of the deletion process for a specific user, including audit timestamps and the identifiers of the users who initiated or modified the request. This is a raw landed copy of the Odoo source table in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_users_deletion_id_seq`. |
| user_id | INTEGER | true | Reference to the user being deleted | Likely links to `res_users.id`. |
| user_id_int | INTEGER | true | Internal user identifier | Redundant or legacy identifier for the user. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| state | VARCHAR | false | Status of the deletion request | e.g., 'draft', 'requested', 'done'. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo naming convention for user references).
    - `create_uid` → `res_users.id` (Standard Odoo audit field for creator).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains `user_id` references which may be linked to PII in the `res_users` table; ensure appropriate access controls are applied.
- **State Logic:** The `state` column is a free-text `VARCHAR` without a defined enum; downstream consumers should inspect distinct values to map business logic.
- **Soft Deletes:** This table appears to be an audit/process log rather than a source of truth for active users; do not use this to determine if a user is currently active in the system.