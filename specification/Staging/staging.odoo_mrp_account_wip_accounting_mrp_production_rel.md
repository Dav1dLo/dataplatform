# odoo_mrp_account_wip_accounting_mrp_production_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) and Accounting modules. The naming convention `_rel` combined with the specific module prefixes (`mrp_account_wip_accounting` and `mrp_production`) indicates this is a standard Odoo many-to-many join table used to link Work-in-Progress (WIP) accounting entries to specific manufacturing production orders.

## Functional process 
This table supports the manufacturing cost accounting process. It facilitates the association between production orders and the WIP accounting records that track the value of materials and labor consumed during the manufacturing lifecycle before the final product is completed and moved to inventory.

## Description
One row in this table represents a single association between a specific WIP accounting record and a manufacturing production order. It serves as a raw junction table in the staging layer, enabling the reconstruction of relationships between financial WIP entries and operational production activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_account_wip_accounting_id | INTEGER | false | Foreign key to the WIP accounting record. | Links to the primary key of the WIP accounting table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | Links to the primary key of the production order table. |

## Keys

- **Primary key (inferred):** The combination of (`mrp_account_wip_accounting_id`, `mrp_production_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_account_wip_accounting_id` → `mrp_account_wip_accounting.id`: This column references the parent WIP accounting entity.
    - `mrp_production_id` → `mrp_production.id`: This column references the parent manufacturing production order entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata; this is a technical join table.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between accounting WIP records and production orders.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present; incremental loading logic must rely on the upstream source system's replication metadata.
- This table contains no sensitive PII or financial values directly, but it is critical for joining operational production data to financial accounting data.