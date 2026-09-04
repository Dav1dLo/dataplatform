# odoo_project_tags

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns is characteristic of Odoo's standard ORM audit fields, and the `name` column being stored as `JSONB` is typical for Odoo's multi-language field handling in PostgreSQL-backed instances.

## Functional process 
This table supports project management and task categorization workflows. It stores the definitions of tags that can be applied to projects or tasks to facilitate filtering, reporting, and organizational grouping within the Odoo Project module.

## Description
One row represents a single project tag definition available for use within the system. This is a raw landed copy of the Odoo `project.tags` model, serving as the base staging entity for downstream project analytics and reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| color | INTEGER | true | UI color index | Represents the color code assigned to the tag in the Odoo interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the tag. |
| name | JSONB | false | Tag display name | Stores localized names; structure typically follows `{"en_US": "Tag Name", ...}`. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Likely references the user who performed the initial creation.
    - `write_uid` → `res_users.id`: Likely references the user who performed the last modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; contains system metadata and tag labels.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** Odoo typically uses hard deletes for this model; however, verify if downstream processes expect historical tracking.
- **JSONB Handling:** The `name` column requires extraction logic (e.g., `name->>'en_US'`) to be used in standard reporting tools.
- **Data Pattern:** This is a raw staging table; expect frequent schema evolution if the upstream Odoo instance is updated.