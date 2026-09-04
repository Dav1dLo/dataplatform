# odoo_project_task_type_delete_wizard

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `project_task_type_delete_wizard` is characteristic of Odoo's "wizard" pattern, which manages transient state for UI-driven operations, in this case, the deletion of task stages or types within the Project module.

## Functional process 
This table supports the Project Management module's administrative workflow, specifically the process of removing task stages (types). It acts as a transient staging area to hold the state of a deletion request before the system performs the final cleanup of associated task records or reassignments.

## Description
One row in this table represents a single execution instance of a task type deletion wizard. It tracks the metadata of the deletion request, including who initiated the process and when it occurred. As a staging table, it provides a raw, landed record of these administrative actions for audit or troubleshooting purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.project_task_type_delete_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the wizard record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the wizard record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column for creator).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column for modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Transient Data:** This table represents a wizard state; records may be short-lived or represent ephemeral UI interactions rather than core business entities.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Audit Columns:** `create_uid` and `write_uid` are system-level identifiers and do not contain PII, but they should be joined against the `res_users` table to resolve human-readable names.
- **Soft Deletes:** There is no explicit soft-delete flag; assume records are either permanent logs of the wizard action or subject to periodic cleanup by the Odoo system.