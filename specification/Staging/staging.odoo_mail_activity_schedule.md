# odoo_mail_activity_schedule

## Source system
This table originates from Odoo ERP, specifically the `mail` module which handles internal communications and activity scheduling. The naming convention `mail_activity_schedule` and the presence of `res_model` and `res_id` fields are characteristic of Odoo's generic activity framework used across CRM, Sales, and Project modules.

## Functional process 
This table supports the automated activity scheduling process, allowing users to define templates or "plans" for follow-up tasks. It tracks the configuration of scheduled activities, including the target model, the assigned user, and the deadline logic, facilitating automated workflows like lead nurturing or project task reminders.

## Description
One row in this table represents a single configuration entry for a scheduled activity or a template for an activity plan. It serves as a raw landed copy of the Odoo `mail.activity.schedule` model, capturing the metadata required to trigger or instantiate tasks against specific business records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| res_model_id | INTEGER | false | ID of the related model | References `ir.model` table. |
| plan_id | INTEGER | true | ID of the activity plan | Links to the parent plan definition. |
| plan_on_demand_user_id | INTEGER | true | User ID for on-demand tasks | The user assigned to perform the task. |
| activity_type_id | INTEGER | true | Activity type ID | References `mail.activity.type`. |
| activity_user_id | INTEGER | true | Assigned user ID | The default user assigned to the activity. |
| create_uid | INTEGER | true | Creator user ID | References `res.users`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res.users`. |
| res_model | VARCHAR | false | Model name | Technical name of the target model (e.g., 'crm.lead'). |
| summary | VARCHAR | true | Activity summary | Short description of the activity. |
| plan_date | DATE | true | Planned date | The scheduled date for the activity. |
| date_deadline | DATE | true | Deadline date | The final date to complete the activity. |
| res_ids | TEXT | true | Related record IDs | Comma-separated list of record IDs. |
| note | TEXT | true | Activity notes | Detailed instructions or context for the activity. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `activity_type_id` → `mail_activity_type.id` (Likely reference to activity configuration).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially sensitive notes; ensure access is restricted to authorized personnel.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `res_ids` column contains a text-based list of IDs, which will require parsing (e.g., `string_to_array`) for relational joins.
- **Soft Deletes:** Odoo typically uses hard deletes for this model; assume no soft-delete flag exists unless `active` column is present (which is absent here).