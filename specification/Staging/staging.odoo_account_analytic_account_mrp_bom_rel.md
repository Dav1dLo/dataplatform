# odoo_account_analytic_account_mrp_bom_rel

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `account_analytic_account_mrp_bom_rel` is characteristic of Odoo's internal many-to-many relationship tables, which link analytic accounting records to Manufacturing Resource Planning (MRP) Bills of Materials (BoM).

## Functional process 
This table supports the integration between cost accounting and manufacturing operations. It enables the system to associate specific analytic accounts (used for tracking costs and revenues) with manufacturing Bills of Materials, allowing for the allocation of production costs to specific projects or cost centers.

## Description
One row in this table represents a single association between an analytic account and a manufacturing Bill of Materials. This is a junction table used to resolve a many-to-many relationship between the `account.analytic.account` and `mrp.bom` entities in the Odoo database. It serves as a raw landed copy of the link table from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_bom_id | INTEGER | false | Foreign key to the MRP Bill of Materials | Links to the primary key of the MRP BoM table. |

## Keys

- **Primary key (inferred):** The combination of `account_analytic_account_id` and `mrp_bom_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: Links to the analytic account definition.
    - `mrp_bom_id` → `mrp_bom.id`: Links to the specific Bill of Materials definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should join or filter using the composite key `(account_analytic_account_id, mrp_bom_id)`.
- As a junction table, it contains only identifiers; it does not contain descriptive attributes or timestamps.
- Ensure that downstream joins handle the potential for multiple analytic accounts per BoM or multiple BoMs per analytic account.