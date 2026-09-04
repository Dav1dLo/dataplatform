# odoo_project_task_type_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of `project_id` and `type_id` are characteristic of Odoo's many-to-many join tables used to map project configurations to specific task stages or types.

## Functional process 
This table supports the project management configuration process, specifically defining which task stages (types) are available or enabled for specific projects. It acts as a bridge to enforce project-specific workflows within the Odoo project management module.

## Description
One row represents a single association between a project and a task type (stage). It is a raw landing copy of a many-to-many relationship table, used to resolve the link between project entities and their allowed task lifecycle stages.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_id | INTEGER | false | Foreign key to the project entity | Links to the primary project definition. |
| type_id | INTEGER | false | Foreign key to the task type/stage entity | Links to the definition of a task stage. |

## Keys

- **Primary key (inferred):** The combination of `(project_id, type_id)` acts as the composite primary key for this relationship.
- **Foreign keys (inferred):** 
    - `project_id` → `project.id` (Inferred from Odoo standard naming conventions).
    - `type_id` → `project_task_type.id` (Inferred from Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table represents the current state of relationships as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphans if the upstream Odoo instance has referential integrity gaps.