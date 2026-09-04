# odoo_account_move_mrp_production_rel

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `account_move_mrp_production_rel` is characteristic of Odoo's internal many-to-many relationship tables, which link accounting journal entries (`account_move`) to manufacturing production orders (`mrp_production`).

## Functional process 
This table supports the manufacturing-to-finance integration process. It tracks the association between specific manufacturing production runs and the corresponding accounting journal entries generated to record costs, material consumption, or finished goods valuation.

## Description
One row in this table represents a single link between a manufacturing production order and an accounting journal entry. It serves as a raw, junction-table copy from the Odoo staging layer, used to resolve many-to-many relationships between the manufacturing and accounting modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_id | INTEGER | false | Foreign key to the accounting journal entry. | References the primary key of the `account_move` table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | References the primary key of the `mrp_production` table. |

## Keys

- **Primary key (inferred):** The composite of (`account_move_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `account_move_id` → `staging.account_move.id`: Links to the specific financial transaction record.
    - `mrp_production_id` → `staging.mrp_production.id`: Links to the specific manufacturing production order.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Ensure inner joins are used when traversing these relationships to avoid orphaned records if the source system has referential integrity gaps.
- As a staging table, this data reflects the raw state of the Odoo database; verify if the source system performs hard or soft deletes on these relationship records.