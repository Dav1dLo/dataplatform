# odoo_hr_employee_hr_skill_rel

## Source system
This table originates from Odoo ERP, specifically the Human Resources module. The naming convention `hr_employee_hr_skill_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link employees to their respective skill sets.

## Functional process 
This table supports the Human Resources skill management process, enabling the mapping of individual employees to specific technical or professional skills. It is used to track workforce capabilities and facilitate resource allocation based on skill profiles.

## Description
One row in this table represents a single association between an employee and a specific skill. It serves as a raw junction table in the staging layer, capturing the many-to-many relationship between the employee master data and the skill master data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| hr_employee_id | INTEGER | false | Foreign key to the employee record | Links to the primary key of the employee table. |
| hr_skill_id | INTEGER | false | Foreign key to the skill record | Links to the primary key of the skill definition table. |

## Keys

- **Primary key (inferred):** The composite key `(hr_employee_id, hr_skill_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `hr_employee_id` → `hr_employee.id` (Inferred from Odoo naming conventions).
    - `hr_skill_id` → `hr_skill.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `created_at` or `updated_at`) present in this table, making it difficult to track the history of skill assignments.
- Ensure that joins to the target tables handle potential orphans if referential integrity is not strictly enforced in the source Odoo instance.