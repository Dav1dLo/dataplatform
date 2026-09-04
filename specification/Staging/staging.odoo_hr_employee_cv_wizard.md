# odoo_hr_employee_cv_wizard

## Source system
This table originates from Odoo ERP, specifically the Human Resources module. The naming convention `hr_employee_cv_wizard` and the presence of `create_uid`/`write_uid` audit columns are characteristic of Odoo's internal wizard models, which manage transient state for UI-driven processes.

## Functional process 
This table supports the "Employee CV Generation" process. It stores the configuration settings for a wizard that allows users to customize the appearance and content of employee CVs, such as color themes and toggles for displaying specific sections like skills or contact information.

## Description
One row in this table represents a single configuration instance of an employee CV generation wizard session. It acts as a raw landed copy of the transient wizard state used by the Odoo application to persist user selections before generating a document.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.hr_employee_cv_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res_users` table. |
| color_primary | VARCHAR | false | Primary theme color | Hex code or color name used for CV styling. |
| color_secondary | VARCHAR | false | Secondary theme color | Hex code or color name used for CV styling. |
| show_skills | BOOLEAN | true | Toggle for skills section | Determines if skills are included in the output. |
| show_contact | BOOLEAN | true | Toggle for contact info | Determines if contact details are included. |
| show_others | BOOLEAN | true | Toggle for other sections | Determines if miscellaneous sections are included. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable. Wizard tables in Odoo are often transient and lack a unique business key.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Persistence:** As a "wizard" table, this data may be transient or subject to frequent cleanup by the source system; do not treat this as a long-term historical record of generated CVs.
- **Sensitivity:** No direct PII is stored in this table, though it contains user IDs and configuration preferences that may be linked to specific employees or internal users.
- **Boolean Nulls:** Boolean columns (`show_skills`, `show_contact`, `show_others`) allow nulls; treat nulls as `FALSE` or "default" depending on the specific Odoo version's business logic.