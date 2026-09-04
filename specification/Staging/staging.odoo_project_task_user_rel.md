# odoo_project_task_user_rel

## Source system
This table originates from Odoo ERP. The naming convention `project_task_user_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link project tasks to assigned users.

## Functional process 
This table supports the project management module's resource allocation process. It tracks the assignment of users (employees) to specific tasks within projects, enabling the system to manage task ownership and workload distribution.

## Description
One row in this table represents a single association between a project task and a user. It serves as a raw landing copy of the Odoo relational join table, capturing the link between task entities and user entities, along with audit metadata for the assignment record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.project_task_user_rel_id_seq`. |
| task_id | INTEGER | false | Foreign key to project task | Links to the task being assigned. |
| user_id | INTEGER | false | Foreign key to system user | Links to the user assigned to the task. |
| stage_id | INTEGER | true | Foreign key to task stage | Represents the specific workflow stage of the assignment. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this assignment record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this assignment record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the assignment was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the assignment was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `task_id` → `staging.project_task.id` (Inferred from Odoo naming convention for task relations).
    - `user_id` → `staging.res_users.id` (Inferred from Odoo naming convention for user relations).
    - `stage_id` → `staging.project_task_type.id` (Inferred from Odoo naming convention for task stages).
- **Natural keys (inferred):** 
    - `(task_id, user_id)`: In Odoo, this pair typically represents the unique business constraint for task-user assignments.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`, `user_id`) which may need to be joined against a user directory to resolve names.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against the source system configuration.
- **Soft Deletes:** Odoo often uses `active` flags (not present here) or hard deletes for relational tables; assume this table contains only active associations unless an `active` column is found in the source.
- **Data Integrity:** As a raw staging table, this may contain orphaned records if the upstream `task_id` or `user_id` were deleted without cascading.