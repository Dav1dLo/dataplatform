# odoo_account_report_section_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the `account_report` prefix is characteristic of Odoo's internal many-to-many relationship tables used to link financial report structures or sections within the accounting module.

## Functional process 
This table supports the financial reporting configuration process. It defines the hierarchical or associative structure of accounting reports, specifically mapping main report definitions to their constituent sub-report sections or sub-components.

## Description
Each row represents a single association between a parent financial report and a child report section or sub-report. This is a junction table used to resolve many-to-many relationships within the Odoo accounting reporting engine, serving as a raw landed copy of the source system's relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| main_report_id | INTEGER | false | Foreign key to the parent report definition | Links to the primary report entity. |
| sub_report_id | INTEGER | false | Foreign key to the child report section | Links to the sub-report or section entity. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`main_report_id`, `sub_report_id`).
- **Foreign keys (inferred):** 
    - `main_report_id` → `account_report.id` (guess: standard Odoo naming pattern for report definitions).
    - `sub_report_id` → `account_report.id` (guess: standard Odoo naming pattern for report sections).
- **Natural keys (inferred):** The combination of (`main_report_id`, `sub_report_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of report configurations in the source system.
- Ensure that joins to the target `account_report` table handle potential missing records if the source system has referential integrity gaps.