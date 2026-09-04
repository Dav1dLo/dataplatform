# odoo_mrp_workorder_wc_analytic_rel

## Source system
This table originates from Odoo ERP. The naming convention `mrp_workorder_wc_analytic_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link Manufacturing Resource Planning (MRP) work orders to analytic accounting lines.

## Functional process 
This table supports the manufacturing cost tracking process. It maps specific work order execution steps to their corresponding analytic accounting entries, allowing the business to attribute labor and machine costs incurred during production to specific analytic accounts (e.g., projects, departments, or cost centers).

## Description
One row represents a single association between an MRP work order and an analytic accounting line. This is a junction table used to resolve a many-to-many relationship between manufacturing operations and financial cost tracking records. It serves as a raw landed copy of the Odoo relational link, intended for joining production data with financial ledger data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the MRP work order | Links to the primary manufacturing work order record. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic account line | Links to the specific financial cost entry. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo often uses a composite primary key on these relationship tables consisting of both columns.
- **Foreign keys (inferred):** 
    - `mrp_workorder_id` → `mrp_workorder.id`: This column references the manufacturing work order entity.
    - `account_analytic_line_id` → `account_analytic_line.id`: This column references the analytic accounting entry.
- **Natural keys (inferred):** The combination of `(mrp_workorder_id, account_analytic_line_id)` is the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or soft-delete flags; this table reflects the current state of the relationship as defined in the Odoo database.
- Ensure that joins to the target tables handle potential missing records if the upstream Odoo instance performs hard deletes on work orders or analytic lines.