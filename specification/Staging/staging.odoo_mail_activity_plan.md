# odoo_mail_activity_plan

## Source system
This table originates from Odoo ERP. The naming convention `mail_activity_plan` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and model-related fields (`res_model`, `res_model_id`) are characteristic of the Odoo framework's activity management module.

## Functional process 
This table supports the automated workflow and task management process within Odoo. It defines "activity plans," which are templates or sequences of activities (such as follow-ups or onboarding tasks) that can be triggered against specific business records (e.g., leads, projects, or employees) to ensure consistent operational workflows.

## Description
One row in this table represents a single activity plan definition, which acts as a template for generating multiple related tasks. It resides in the Staging layer as a raw, direct copy of the Odoo database table, intended for use in downstream modeling of business process automation and task completion metrics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Foreign key to the company | Links the plan to a specific organization unit. |
| res_model_id | INTEGER | false | Foreign key to the model definition | References the Odoo model this plan applies to. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the plan. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the plan. |
| name | VARCHAR | false | Plan name | The human-readable title of the activity plan. |
| res_model | VARCHAR | false | Model technical name | The technical string identifier of the target model. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the plan is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| department_id | INTEGER | true | Department ID | Links the plan to a specific internal department. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
    - `department_id` → `hr_department.id` (Likely link to HR structure).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined to `res_users` to identify individuals.
- **Timestamps:** Timestamps are stored in the Odoo server time (typically UTC); verify against the source Odoo configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` unless historical/archived plans are required.
- **Data Integrity:** As a staging table, this is a raw dump; expect potential inconsistencies in foreign key references if the source system has orphan records.