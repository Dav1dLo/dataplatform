# odoo_project_tags_project_task_rel

## Source system
This table originates from Odoo ERP. The naming convention `<table>_<relation_name>_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the project management module by facilitating the many-to-many relationship between project tasks and their associated tags. It allows a single task to be categorized by multiple tags and a single tag to be applied to multiple tasks.

## Description
One row in this table represents a single association between a specific project task and a specific tag. It serves as a raw junction table in the staging layer, capturing the link between the task entity and the tag entity as defined in the source Odoo instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_id | INTEGER | false | Foreign key to the project task | Links to the primary key of the task table. |
| project_tags_id | INTEGER | false | Foreign key to the project tag | Links to the primary key of the tag table. |

## Keys

- **Primary key (inferred):** The composite key `(project_task_id, project_tags_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `project_task_id` → `project_task.id`: This column references the unique identifier of a task record.
    - `project_tags_id` → `project_tags.id`: This column references the unique identifier of a tag record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship.
- There are no audit timestamps (e.g., `created_at` or `updated_at`) present in this table, making it difficult to determine the history of when associations were created or removed.
- As a raw staging table, it does not contain soft-delete flags; if a record is removed from the source Odoo database, it is likely removed from this table as well.