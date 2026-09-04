# odoo_mrp_production_split

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_production_split` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the manufacturing production splitting process, which allows a single manufacturing order to be divided into smaller batches or sub-orders. It tracks the relationship between the parent manufacturing order and the split instances, likely used to manage partial production runs or parallel processing of a single work order.

## Description
One row in this table represents a single split event or sub-batch record associated with a manufacturing production order. It serves as a raw landing copy of the Odoo `mrp.production.split` model, capturing the structural metadata required to track how production orders are partitioned.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| production_split_multi_id | INTEGER | true | Foreign key to the parent split group | Links this split to a multi-split configuration. |
| production_id | INTEGER | true | Foreign key to the manufacturing order | References the parent `mrp.production` record. |
| counter | INTEGER | true | Split sequence counter | Indicates the ordinal position or iteration of the split. |
| create_uid | INTEGER | true | Creator user ID | References `res.users` who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References `res.users` who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application layer. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `production_id` → `staging.odoo_mrp_production.id` (Guess: links to the main manufacturing order).
    - `create_uid` → `staging.odoo_res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `staging.odoo_res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user references (`create_uid`, `write_uid`) which may need to be joined with user tables to identify specific employees.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's standard database behavior.
- **Data Integrity:** As a staging table, this may contain transient records or duplicates if the ingestion process is not idempotent; verify row counts against the source system if performing reconciliation.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source unless an audit log module is active.