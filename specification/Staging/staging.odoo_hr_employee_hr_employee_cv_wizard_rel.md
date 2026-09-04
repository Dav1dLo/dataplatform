# odoo_hr_employee_hr_employee_cv_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefix `hr_employee_cv_wizard` indicates this is a standard Odoo join table used to manage many-to-many relationships between employee records and CV wizard session objects.

## Functional process 
This table supports the Human Resources module, specifically the "Print/Export CV" workflow. It tracks the association between specific employee records and the temporary wizard instances used to generate or manage employee CV documents.

## Description
One row represents a single association between an employee and a CV wizard session. This is a raw landed join table used to resolve the many-to-many relationship required for the Odoo UI to process bulk or individual CV generation tasks.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| hr_employee_cv_wizard_id | INTEGER | false | Foreign key to the CV wizard session | Links to the parent wizard instance. |
| hr_employee_id | INTEGER | false | Foreign key to the employee record | Links to the specific employee being processed. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`hr_employee_cv_wizard_id`, `hr_employee_id`).
- **Foreign keys (inferred):** 
    - `hr_employee_cv_wizard_id` → `hr_employee_cv_wizard.id` (Inferred from Odoo naming conventions for wizard relations).
    - `hr_employee_id` → `hr_employee.id` (Standard Odoo foreign key pattern for employee entities).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a link table; it contains no business data other than the relationship identifiers.
- Expect high churn in this table as wizard sessions are typically temporary and often purged by Odoo's cleanup routines.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.