# odoo_pos_hr_basic_employee_hr_employee

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `odoo_pos_hr_basic_employee_hr_employee` indicates a join table or link table used to associate specific employees with POS configurations, likely to manage access rights or shift assignments within the Odoo HR and POS integration.

## Functional process 
This table supports the Point of Sale management process by defining which employees are authorized or assigned to work at specific POS terminals or configurations. It acts as a mapping entity to ensure that HR employee records are correctly linked to the operational POS environment.

## Description
One row in this table represents a single association between a POS configuration and an HR employee. It serves as a raw landed link table in the staging layer, capturing the relationship required to validate or filter employee access within the POS interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Represents the specific terminal or shop setup. |
| hr_employee_id | INTEGER | false | Foreign key to the HR employee record | Represents the unique identifier for the staff member. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`pos_config_id`, `hr_employee_id`).
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: Links to the POS configuration definition.
    - `hr_employee_id` → `hr_employee.id`: Links to the master employee record.
- **Natural keys (inferred):** The combination of (`pos_config_id`, `hr_employee_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a link table; expect no descriptive attributes, only identifiers.
- Ensure referential integrity checks are performed against the `pos_config` and `hr_employee` tables before joining.
- As a staging table, this may contain historical associations that are no longer active in the source system; check for corresponding "active" flags in the source if available.