# odoo_mail_activity_plan_template

## Source system
This table originates from Odoo ERP. The naming convention `mail_activity_plan_template` and the presence of Odoo-specific audit columns like `create_uid`, `write_uid`, and `*_date` are characteristic of the Odoo framework's internal activity management module.

## Functional process 
This table supports the "Activity Plan" business process, which allows users to define templates for sequences of automated tasks or reminders. It links specific activity types to a parent plan, determining the timing (`delay_count`, `delay_unit`) and responsibility for each step in a workflow.

## Description
One row in this table represents a single activity step within a predefined activity plan template. It acts as a raw landed copy of the Odoo `mail.activity.plan.template` model, capturing the configuration for tasks that are triggered during business processes like lead nurturing or project onboarding.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| plan_id | INTEGER | false | Foreign key to the parent plan | Links this activity to a specific `mail.activity.plan`. |
| sequence | INTEGER | true | Display order | Determines the order of activities within the plan. |
| activity_type_id | INTEGER | false | Activity type reference | Links to the `mail.activity.type` configuration. |
| delay_count | INTEGER | true | Time offset value | The numeric value for the delay calculation. |
| responsible_id | INTEGER | true | Responsible user/resource ID | The ID of the user or resource assigned to the activity. |
| create_uid | INTEGER | true | Creator user ID | Audit: ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit: ID of the user who last updated the record. |
| delay_unit | VARCHAR | false | Time unit | Unit for the delay (e.g., 'days', 'weeks', 'months'). |
| delay_from | VARCHAR | false | Reference point | The anchor for the delay (e.g., 'current_date', 'before_deadline'). |
| summary | VARCHAR | true | Activity summary | Short description or title of the activity. |
| responsible_type | VARCHAR | false | Responsibility logic | Defines how the responsible party is determined. |
| note | TEXT | true | Detailed instructions | Rich text or plain text notes for the activity. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit: Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit: Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `plan_id` → `staging.odoo_mail_activity_plan.id` (Inferred from Odoo naming conventions).
    - `activity_type_id` → `staging.odoo_mail_activity_type.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to user records; ensure these are handled according to internal PII/access policies.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against the source instance configuration.
- **Soft Deletes:** Odoo typically uses hard deletes for configuration tables; assume no soft-delete flag exists unless explicitly present in the source schema.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should allocate sufficient buffer (e.g., 255 characters) for these fields.