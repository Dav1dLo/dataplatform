# odoo_hr_department

## Source system
This table originates from Odoo ERP, specifically the Human Resources module. The naming convention (`hr_department`), the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of `JSONB` for localized names are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the organizational structure management process within the HR module. It defines the hierarchy of departments, linking them to parent departments and managers, which is essential for reporting lines, resource allocation, and organizational charting.

## Description
One row in this table represents a single department or organizational unit within the company. It acts as a raw landed copy of the Odoo `hr_department` table, capturing the hierarchical structure, associated managers, and metadata for each department.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.hr_department_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links to the owning company entity. |
| parent_id | INTEGER | true | Parent department ID | Used to build the organizational tree. |
| manager_id | INTEGER | true | Department manager ID | References the employee acting as manager. |
| color | INTEGER | true | UI color index | Used for visual categorization in the Odoo UI. |
| master_department_id | INTEGER | true | Master department reference | Used for grouping departments under a master unit. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| complete_name | VARCHAR | true | Full hierarchical name | Denormalized path (e.g., "Parent / Child"). |
| parent_path | VARCHAR | true | Materialized path | Used for efficient tree traversal queries. |
| name | JSONB | false | Department name | Multilingual field; contains localized strings. |
| note | TEXT | true | Department description | Free-text field for internal notes. |
| active | BOOLEAN | true | Soft-delete flag | If false, the department is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `parent_id` → `hr_department.id` (Self-referencing hierarchy).
    - `manager_id` → `hr_employee.id` (Standard Odoo HR link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `note` fields may contain sensitive internal information.
- **Timezones:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical analysis is required.
- **JSONB:** The `name` column is a `JSONB` object; downstream consumers will need to extract the relevant language key (e.g., `name->>'en_US'`).
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., `1/5/12`); this is useful for recursive queries but should be treated as a denormalized helper.