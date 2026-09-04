# odoo_project_task_type

## Source system
This table originates from Odoo ERP, specifically the Project management module. The naming convention (`odoo_project_task_type`) and the presence of Odoo-specific fields like `create_uid`, `write_uid`, and `JSONB` name fields (typical for Odoo's multi-language support) confirm this as a direct extraction from an Odoo PostgreSQL database.

## Functional process 
This table supports the project task workflow configuration, specifically defining the "stages" or "kanban columns" that tasks move through (e.g., "To Do", "In Progress", "Done"). It manages the business logic for task lifecycle transitions, including automated email/SMS notifications and user assignments associated with specific project stages.

## Description
One row represents a single project task stage definition within the Odoo project module. It acts as a raw landed copy of the Odoo `project.task.type` model, capturing configuration settings such as stage sequence, fold status, and associated communication templates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| sequence | INTEGER | true | Display order | Determines the horizontal position in Kanban views. |
| mail_template_id | INTEGER | true | Email template ID | Foreign key to email templates for automated notifications. |
| rating_template_id | INTEGER | true | Rating template ID | Foreign key to customer satisfaction survey templates. |
| user_id | INTEGER | true | Responsible user ID | Foreign key to the user assigned to this stage. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created this stage. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated this stage. |
| name | JSONB | false | Stage name | Multi-language string storage; requires extraction for display. |
| active | BOOLEAN | true | Soft-delete flag | If false, the stage is hidden from the UI. |
| fold | BOOLEAN | true | Kanban fold status | If true, the stage is collapsed in the Kanban view. |
| auto_validation_state | BOOLEAN | true | Auto-validation flag | Logic trigger for automated state transitions. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on standard Odoo behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on standard Odoo behavior. |
| sms_template_id | INTEGER | true | SMS template ID | Foreign key to SMS templates for automated notifications. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: links to Odoo email templates)
    - `user_id` → `res_users.id` (Guess: links to system users)
    - `create_uid` / `write_uid` → `res_users.id` (Guess: links to system users)
- **Natural keys (inferred):** Not confidently inferable. Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column is stored as `JSONB`. You must use the `->>` operator (e.g., `name->>'en_US'`) to extract the string value for reporting.
- **Timestamps:** Timestamps are stored in UTC. Ensure local timezone conversions are applied if required by business logic.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing an audit.
- **Data Integrity:** As a staging table, this may contain orphaned foreign keys if the source system has undergone cleanup or partial data migration.