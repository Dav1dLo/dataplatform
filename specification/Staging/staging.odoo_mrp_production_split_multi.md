# odoo_mrp_production_split_multi

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_production_split_multi` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables used to track multi-split operations within production orders.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the splitting of production orders into multiple batches or sub-lots. It records the audit trail for when production splits are created or modified, facilitating traceability in the shop floor control and inventory management workflows.

## Description
One row in this table represents a single record of a production split operation within the Odoo MRP module. It serves as a raw landed copy of the Odoo database table, capturing the audit metadata for split events at the grain of an individual split record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from Odoo. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo res_users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo res_users table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record updates).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Audit Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Completeness:** This table contains only audit metadata; it lacks the business-logic columns (e.g., `production_id`, `quantity`) typically associated with a split, suggesting this might be a join table or a partial extraction.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source database unless otherwise specified by the Odoo module configuration.
- **PII:** `create_uid` and `write_uid` link to user identities; ensure access controls are applied if mapping these to human-readable names in downstream reporting.