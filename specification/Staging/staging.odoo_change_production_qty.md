# odoo_change_production_qty

## Source system
This table originates from Odoo ERP. The naming convention (`mo_id`, `create_uid`, `write_uid`) and the specific pattern of tracking production quantity changes are characteristic of Odoo's Manufacturing (MRP) module, where `mo_id` refers to a Manufacturing Order.

## Functional process 
This table supports the manufacturing execution process by logging adjustments to the planned production quantities for manufacturing orders. It tracks the history of quantity modifications, allowing for auditability of changes made to production targets during the manufacturing lifecycle.

## Description
One row in this table represents a single adjustment event where the planned quantity of a specific manufacturing order was modified. This is a raw landed copy of the Odoo `change.production.qty` wizard log or related tracking table, capturing the state of quantity changes at the grain of an individual update event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.change_production_qty_id_seq`. |
| mo_id | INTEGER | false | Foreign key to the Manufacturing Order | Links to the parent production record. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the change. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| product_qty | NUMERIC | false | The new production quantity | The target quantity set during this change event. |
| create_date | TIMESTAMP | true | Creation timestamp | Ingestion timestamp from Odoo; assume UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Ingestion timestamp from Odoo; assume UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mo_id` → `mrp_production.id` (Inferred based on Odoo naming conventions for manufacturing orders).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are sourced directly from Odoo; assume UTC unless otherwise specified by the Odoo instance configuration.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records, which may contain PII; ensure appropriate access controls are applied when joining to user dimension tables.
- **Soft Deletes:** This table appears to be an append-only log of changes; there is no explicit `active` or `deleted` flag present.
- **Precision:** `product_qty` is defined as `NUMERIC` without explicit scale/precision; verify if downstream systems require casting to a specific decimal precision (e.g., `NUMERIC(16,4)`).