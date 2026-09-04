# odoo_task_dependencies_rel

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `_rel` is characteristic of Odoo's internal implementation of many-to-many relationship tables, which are used to link records across different modules.

## Functional process 
This table supports the project management module by defining the dependency graph between tasks. It tracks which tasks must be completed before another task can begin, facilitating critical path analysis and project scheduling.

## Description
One row in this table represents a single directed dependency relationship between two tasks. It is a raw landing copy of the Odoo join table, serving as the bridge to resolve many-to-many associations between tasks in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| task_id | INTEGER | false | The ID of the dependent task. | References the primary key of the task table. |
| depends_on_id | INTEGER | false | The ID of the prerequisite task. | References the primary key of the task table. |

## Keys

- **Primary key (inferred):** The composite key `(task_id, depends_on_id)` is the inferred primary key, as it represents the unique link between two specific tasks.
- **Foreign keys (inferred):** 
    - `task_id` → `staging.odoo_task.id`: This column identifies the task that is waiting for a dependency.
    - `depends_on_id` → `staging.odoo_task.id`: This column identifies the task that must be finished first.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata; the relationship is defined by the surrogate IDs of the source system.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it represents the current state of dependencies as captured during the last ingestion.
- There is no soft-delete flag; if a dependency is removed in the source system, the row will likely be absent from the next ingestion.
- Ensure that queries account for potential circular dependencies, as the source system may not strictly enforce acyclic graphs at the database level.