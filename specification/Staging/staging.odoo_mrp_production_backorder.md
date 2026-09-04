# odoo_mrp_production_backorder

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_production_backorder` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the manufacturing execution process, specifically tracking backorders generated when a production order is partially completed. It manages the relationship between original production requests and the subsequent split orders required to fulfill the remaining quantity.

## Description
One row in this table represents a single backorder record associated with a manufacturing production order. It serves as a raw landing copy of the Odoo database state, capturing the audit trail of when a backorder was created or modified within the MRP workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.mrp_production_backorder_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Odoo default is UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Odoo default is UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo user IDs; they will not resolve to meaningful names without joining against the `res_users` table.
- **Data Retention:** This is a raw staging table; it contains the state as captured during the last ingestion. It does not explicitly indicate if it tracks historical versions or only the current state of backorders.