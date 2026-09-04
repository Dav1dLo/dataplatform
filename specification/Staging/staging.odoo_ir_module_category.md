# odoo_ir_module_category

## Source system
This table originates from Odoo ERP, as indicated by the `ir_module_category` naming convention, which is a standard internal table name in the Odoo framework used to manage module categorization within the system's technical metadata.

## Functional process 
This table supports the application configuration and module management process. It defines the hierarchical categories used to organize Odoo modules (apps) within the interface, allowing for structured navigation and grouping of functional extensions.

## Description
One row in this table represents a single category definition used to group Odoo modules. It acts as a raw landed copy of the Odoo `ir.module.category` model, capturing the hierarchical structure, display settings, and localization-ready names and descriptions for each category.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the category. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this category record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |
| write_uid | INTEGER | true | Modifier user ID | References the user who last updated this record. |
| parent_id | INTEGER | true | Parent category ID | Self-referencing foreign key to create a category hierarchy. |
| name | JSONB | false | Category name | Multilingual name stored as JSON; likely contains language keys. |
| sequence | INTEGER | true | Display order | Integer used to determine the sort order in the UI. |
| description | JSONB | true | Category description | Multilingual description stored as JSON. |
| visible | BOOLEAN | true | Visibility flag | Determines if the category is shown in the module menu. |
| exclusive | BOOLEAN | true | Exclusive flag | Indicates if a module can belong to only one category. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_ir_module_category.id`: Represents the parent-child relationship in the category tree.
    - `create_uid` → `staging.res_users.id` (guess): Standard Odoo pattern for tracking record creators.
    - `write_uid` → `staging.res_users.id` (guess): Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `description` columns are `JSONB`. Downstream queries will need to use PostgreSQL JSON operators (e.g., `->>`) to extract specific language strings.
- **Timestamps:** Timestamps are stored in the database's native format; verify if the Odoo instance is configured for UTC, as Odoo typically stores all timestamps in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Hierarchy:** The `parent_id` column allows for recursive structures; ensure recursive CTEs are used if traversing the full category tree.