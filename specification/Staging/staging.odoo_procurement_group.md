# odoo_procurement_group

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `partner_id`, `create_uid`, `write_uid`, `procurement_group`) and the specific sequence-based ID generation are characteristic of the Odoo framework's internal data model for managing supply chain and procurement workflows.

## Functional process 
This table supports the procurement and inventory replenishment process. It acts as a grouping mechanism for stock moves, linking various demand sources—such as Point of Sale orders (`pos_order_id`) or Sales orders (`sale_id`)—to the corresponding procurement or fulfillment activities.

## Description
One row in this table represents a single procurement group, which serves as a logical container to consolidate stock moves originating from the same business transaction. This is a raw landed copy of the Odoo `procurement.group` model, capturing the audit trail and the association between the group and its parent sales or POS transaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.procurement_group_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the customer/partner | Links to the associated business partner. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo user table. |
| name | VARCHAR | false | Procurement group identifier | Usually a human-readable string or code. |
| move_type | VARCHAR | true | Stock move strategy | Defines how moves are grouped (e.g., direct, one-at-a-time). |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| pos_order_id | INTEGER | true | Foreign key to POS order | Links to the Point of Sale module. |
| sale_id | INTEGER | true | Foreign key to Sales order | Links to the Sales module. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming convention for partners).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit fields).
    - `pos_order_id` → `pos_order.id` (Direct link to POS module).
    - `sale_id` → `sale_order.id` (Direct link to Sales module).
- **Natural keys (inferred):** `name` (Odoo procurement groups are typically identified by a unique string name).

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume it contains all records currently present in the source system.
- **Sensitivity:** Contains `partner_id` which may link to PII in the `res_partner` table; ensure appropriate access controls are applied.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream consumers should handle variable-length strings defensively.