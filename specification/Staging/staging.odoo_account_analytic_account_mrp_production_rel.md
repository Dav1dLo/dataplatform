# odoo_account_analytic_account_mrp_production_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_analytic_account_mrp_production_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link analytic accounting records with manufacturing production orders.

## Functional process 
This table supports the Manufacturing (MRP) and Analytic Accounting integration process. It tracks the association between specific production orders and analytic accounts, allowing costs incurred during the manufacturing process to be tracked against specific projects, departments, or cost centers defined in the analytic accounting module.

## Description
One row in this table represents a single link between an analytic account and a manufacturing production order. It serves as a raw, junction-table copy from the Odoo database, facilitating the many-to-many relationship required to map production costs to analytic dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | References the primary key of the analytic account table. |
| mrp_production_id | INTEGER | false | Foreign key to the production order | References the primary key of the manufacturing production order table. |

## Keys

- **Primary key (inferred):** The combination of `account_analytic_account_id` and `mrp_production_id`.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id` (Inferred from Odoo naming conventions).
    - `mrp_production_id` → `mrp_production.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that joins to the parent tables (`account_analytic_account` and `mrp_production`) handle potential orphans if the ingestion process for those tables is not perfectly synchronized.