# odoo_hr_resume_line_type

## Source system
This table originates from Odoo ERP, specifically the Human Resources module. The naming convention `hr_resume_line_type` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the HR master data management process, specifically defining the categories or types of resume entries (e.g., "Education", "Experience", "Certification") used within the employee profile management system. It acts as a lookup table to standardize how resume line items are classified across the organization.

## Description
Each row represents a unique classification type for resume line items within the Odoo HR module. This is a raw landing table in the staging layer, containing a direct copy of the Odoo database table used to categorize employee background data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.hr_resume_line_type_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to control the sort order in the Odoo UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| name | JSONB | false | Display name | Multilingual label stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo audit field referencing the user who created the record.
    - `write_uid` → `res_users.id`: Standard Odoo audit field referencing the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo often relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains configuration/lookup data.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all rows are current unless Odoo's internal logic dictates otherwise.
- **JSONB Handling:** The `name` column is stored as `JSONB`. Downstream consumers will need to extract the specific language key (e.g., `name->>'en_US'`) to use this in reporting.