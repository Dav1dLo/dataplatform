# odoo_project_task_type_project_task_type_delete_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module-related entities (`project_task_type` and `delete_wizard`) is characteristic of Odoo's automated many-to-many relationship tables generated for wizard-based operations.

## Functional process 
This table supports the project management module's task configuration process, specifically the "Delete Task Type" wizard. It tracks the association between a specific wizard instance and the task stages (types) selected for deletion, facilitating the cleanup or reassignment of tasks associated with those stages.

## Description
One row represents a single association between a task deletion wizard instance and a specific project task stage. This is a raw landing of an Odoo join table, representing the many-to-many relationship required to process batch deletions of task stages within the Odoo UI.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the wizard instance | Links to the parent wizard record. |
| project_task_type_id | INTEGER | false | Foreign key to the task stage | Identifies the specific task stage selected for deletion. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`project_task_type_delete_wizard_id`, `project_task_type_id`).
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Inferred from Odoo naming conventions for wizard relations).
    - `project_task_type_id` → `project_task_type.id` (Inferred from Odoo naming conventions for task stage entities).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a transient join table used by an Odoo wizard; records here are likely short-lived and purged after the wizard process completes.
- There is no audit timestamp or soft-delete flag; this represents the state of the wizard's selection at the time of ingestion.
- Ensure joins to parent tables handle potential orphan records if the ingestion process captures the wizard state mid-transaction.