# odoo_pos_hr_advanced_employee_hr_employee

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module with the "HR Advanced" extension. The naming convention `pos_config_id` and `hr_employee_id` is characteristic of Odoo's relational mapping tables used to link POS configurations to authorized employees.

## Functional process 
This table supports the POS access control and staff management process. It defines the relationship between specific Point of Sale configurations and the employees authorized to operate them, likely used to filter employee lists or manage permissions within the POS interface.

## Description
One row in this table represents a single association between a POS configuration and an employee. It serves as a raw landing copy of the join table used in the Odoo backend to manage multi-employee access rights for POS terminals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the specific POS terminal or shop setup. |
| hr_employee_id | INTEGER | false | Foreign key to the HR employee record | Identifies the employee authorized for the POS config. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`pos_config_id`, `hr_employee_id`).
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id` (Inferred from Odoo naming conventions).
    - `hr_employee_id` → `hr_employee.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of (`pos_config_id`, `hr_employee_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a join entity; it contains no descriptive attributes, only relational identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract, so incremental loading based on time is not possible without joining to the source system's audit columns.
- Ensure that joins to `hr_employee` and `pos_config` handle potential missing records if the staging layer is not fully synchronized.