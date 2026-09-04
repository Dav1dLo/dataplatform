# odoo_mrp_workorder_mo_analytic_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workorder_mo_analytic_rel` is characteristic of Odoo's internal many-to-many relationship tables, which link manufacturing work orders to analytic accounting lines for cost tracking.

## Functional process 
This table supports the manufacturing cost accounting process. It links specific manufacturing work orders to analytic accounting lines, allowing the business to attribute labor, machine time, or material costs incurred during a work order to specific analytic accounts (e.g., projects, departments, or cost centers).

## Description
One row represents a single association between a manufacturing work order and an analytic accounting line. This is a junction table used to resolve a many-to-many relationship between the MRP and Accounting modules. It serves as a raw landing copy of the Odoo relational link, intended for use in downstream transformations to calculate total manufacturing costs per project or work center.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the manufacturing work order. | References `mrp_workorder.id`. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic accounting line. | References `account_analytic_line.id`. |

## Keys

- **Primary key (inferred):** The combination of `(mrp_workorder_id, account_analytic_line_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_workorder_id` → `mrp_workorder.id`: Links to the specific manufacturing work order record.
    - `account_analytic_line_id` → `account_analytic_line.id`: Links to the specific financial/cost tracking line.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no descriptive data, only relational IDs; it must be joined with the parent `mrp_workorder` and `account_analytic_line` tables to be meaningful.
- As a junction table in Odoo, this record is managed by the application's ORM; it does not contain audit timestamps (e.g., `create_date` or `write_date`).
- There is no soft-delete flag; records are typically removed from this table when the association is deleted in the Odoo UI.