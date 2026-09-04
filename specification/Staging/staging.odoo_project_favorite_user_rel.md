# odoo_project_favorite_user_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between business entities.

## Functional process 
This table supports the project management module's "favorite" functionality. It tracks which users have marked specific projects as favorites, allowing the UI to filter or highlight preferred projects for individual users.

## Description
One row represents a single association between a user and a project they have marked as a favorite. This is a raw landing of a many-to-many join table, serving as the source for downstream dimension or bridge tables that track user-specific project preferences.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_id | INTEGER | false | Foreign key to the project entity | References the primary key of the project table. |
| user_id | INTEGER | false | Foreign key to the user entity | References the primary key of the res_users table. |

## Keys

- **Primary key (inferred):** The composite key `(project_id, user_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `project_id` → `project.id`: This column links to the project definition table.
    - `user_id` → `res_users.id`: This column links to the Odoo user identity table.
- **Natural keys (inferred):** The combination of `(project_id, user_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure your join logic handles the composite key correctly.
- As a junction table, it contains no timestamps or audit metadata; it only represents the existence of a relationship.
- There is no soft-delete flag; if a row is missing, the relationship is considered removed in the source system.