# hr_employee_public

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `resource_calendar_id`, and the `_id` suffix pattern used for relational foreign keys.

## Functional process 
This table supports the Human Resources management process, specifically the maintenance of employee profiles, organizational hierarchy, and contact information. It facilitates the tracking of employee assignments to departments, jobs, and work locations, as well as managing internal resource scheduling and reporting lines.

## Description
One row in this table represents a single employee record within the organization. It serves as a raw landed copy of the employee master data, capturing both personal contact details and organizational metadata. The grain of the table is one row per unique employee identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| name | VARCHAR | true | Employee full name | |
| active | BOOLEAN | true | Soft-delete status flag | True if the employee is currently active |
| color | INTEGER | true | UI color index | Used for calendar or interface grouping |
| department_id | INTEGER | true | Foreign key to department | |
| job_id | INTEGER | true | Foreign key to job position | |
| job_title | VARCHAR | true | Descriptive job title | |
| company_id | INTEGER | true | Foreign key to company | |
| address_id | INTEGER | true | Foreign key to address book | |
| work_phone | VARCHAR | true | Business phone number | |
| mobile_phone | VARCHAR | true | Business mobile number | |
| work_email | VARCHAR | true | Business email address | PII: Mask if necessary |
| work_contact_id | INTEGER | true | Foreign key to contact record | |
| work_location_id | INTEGER | true | Foreign key to work location | |
| user_id | INTEGER | true | Foreign key to system user | Links employee to a login account |
| resource_id | INTEGER | true | Foreign key to resource | |
| resource_calendar_id | INTEGER | true | Foreign key to work calendar | |
| is_flexible | BOOLEAN | true | Flexible work flag | |
| is_fully_flexible | BOOLEAN | true | Full flexibility flag | |
| parent_id | INTEGER | true | Manager/Supervisor ID | Self-referencing FK to this table |
| coach_id | INTEGER | true | Coach/Mentor ID | Self-referencing FK to this table |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| id | INTEGER | true | Internal surrogate primary key | |
| create_uid | INTEGER | true | User ID who created the record | |
| write_uid | INTEGER | true | User ID who last updated the record | |
| write_date | TIMESTAMP | true | Last update timestamp | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `department_id` → `hr_department.id` (Inferred from Odoo naming convention)
    - `parent_id` → `hr_employee_public.id` (Self-reference for reporting hierarchy)
    - `coach_id` → `hr_employee_public.id` (Self-reference for mentorship)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
- **Natural keys (inferred):** 
    - `work_email` (Assuming unique business email addresses)

## Caveats for downstream consumers

- **PII:** The `work_email`, `work_phone`, and `mobile_phone` columns contain personally identifiable information and should be handled according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column indicates a soft-delete pattern; queries should typically filter by `WHERE active = TRUE` unless historical analysis is required.
- **Data Types:** The `VARCHAR` columns do not specify length; these are raw imports and may contain varying string lengths depending on the source configuration.