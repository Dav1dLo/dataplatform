# odoo_mail_activity_todo_create

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `mail_activity` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the task management and CRM activity tracking process within Odoo. It captures "To-Do" style activities assigned to users, tracking deadlines, summaries, and detailed notes associated with specific business interactions.

## Description
One row in this table represents a single "To-Do" activity record created within the Odoo mail system. It serves as a raw landing copy of activity data, capturing the assignment, scheduling, and content of tasks at the grain of one row per activity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.mail_activity_todo_create_id_seq`. |
| user_id | INTEGER | false | Assigned user ID | Foreign key to the Odoo res_users table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| summary | VARCHAR | true | Activity summary | Short description of the task. |
| date_deadline | DATE | false | Due date | The date by which the activity should be completed. |
| note | TEXT | true | Detailed notes | Rich text or long-form description of the activity. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for user assignment).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record authorship).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `note` column may contain PII or internal communication; ensure appropriate masking if exposed to non-authorized roles.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo; verify against system configuration if local time conversion is required.
- **Soft Deletes:** Odoo often uses `active` flags (not present here) for soft deletes; if this table lacks an `active` column, assume all rows are currently active or that deletions are hard-deleted at the source.
- **Data Precision:** `VARCHAR` and `TEXT` lengths are not explicitly constrained in the source DDL; downstream systems should handle variable-length strings gracefully.