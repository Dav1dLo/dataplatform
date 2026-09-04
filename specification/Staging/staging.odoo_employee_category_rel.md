# odoo_employee_category_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `employee_id` and `category_id` is characteristic of Odoo's internal many-to-many relationship tables, which are used to link records across different modules.

## Functional process 
This table supports the Human Resources management process by mapping employees to their respective categories or tags (e.g., "Full-time", "Remote", "Management"). It facilitates the categorization of personnel for reporting, payroll, or access control purposes.

## Description
One row in this table represents a single association between an employee and a specific category. It is a raw, junction table used to resolve a many-to-many relationship between the employee entity and the category entity in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| employee_id | INTEGER | false | Foreign key to the employee record | References the primary key of the employee table. |
| category_id | INTEGER | false | Foreign key to the category record | References the primary key of the employee category table. |

## Keys

- **Primary key (inferred):** The composite key `(employee_id, category_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `employee_id` → `employee.id`: This column links to the main employee registry.
    - `category_id` → `hr_employee_category.id`: This column links to the definition of the category.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract, so tracking the history of when an employee was added to a category is not possible from this table alone.
- Ensure that joins to this table are handled as a composite key to avoid fan-out issues.