# odoo_account_analytic_account_mrp_workcenter_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_analytic_account_mrp_workcenter_rel` is characteristic of Odoo's internal many-to-many relationship tables, which use the `_rel` suffix to link two distinct functional modules: the Analytic Accounting module (`account_analytic_account`) and the Manufacturing Resource Planning module (`mrp_workcenter`).

## Functional process 
This table supports the Manufacturing and Cost Accounting integration process. It maps analytic accounts (used for cost tracking and project accounting) to specific manufacturing work centers, allowing costs incurred at a work center to be allocated to the appropriate analytic account for financial reporting and project profitability analysis.

## Description
One row in this table represents a single association between an analytic account and a manufacturing work center. It serves as a raw landing copy of the join table used by Odoo to maintain the many-to-many relationship between these two entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_workcenter_id | INTEGER | false | Foreign key to the manufacturing work center | Links to the primary key of the work center table. |

## Keys

- **Primary key (inferred):** The composite of (`account_analytic_account_id`, `mrp_workcenter_id`).
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `staging.account_analytic_account.id`: This column references the analytic account entity.
    - `mrp_workcenter_id` → `staging.mrp_workcenter.id`: This column references the manufacturing work center entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present in this table; assume it reflects the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphan records if the source system's referential integrity is not strictly enforced.