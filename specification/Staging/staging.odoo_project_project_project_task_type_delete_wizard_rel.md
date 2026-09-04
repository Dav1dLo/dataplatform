# odoo_project_project_project_task_type_delete_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_project_project_project_task_type_delete_wizard_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link wizard-based deletion operations to specific project entities.

## Functional process 
This table supports the project management module's cleanup process, specifically the "Delete Task Type" wizard. It tracks the association between a temporary deletion wizard instance and the projects affected by the removal of specific task stages (kanban states).

## Description
One row represents a single association between a project and a task-type deletion wizard instance. It serves as a raw landing copy of the Odoo relational join table, facilitating the batch processing of project-level configuration changes during stage deletion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the deletion wizard instance | Links to the wizard session managing the deletion. |
| project_project_id | INTEGER | false | Foreign key to the project entity | Identifies the project impacted by the wizard action. |

## Keys

- **Primary key (inferred):** The combination of `project_task_type_delete_wizard_id` and `project_project_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Inferred from Odoo naming convention for wizard relations).
    - `project_project_id` → `project_project.id` (Standard Odoo link to the project master table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table for a transient wizard process; data here is likely short-lived and purged by Odoo after the wizard completes.
- There are no timestamps or audit columns; rely on the parent wizard table for execution context.
- Ensure joins to `project_project` are handled as inner joins if you only require active project associations.