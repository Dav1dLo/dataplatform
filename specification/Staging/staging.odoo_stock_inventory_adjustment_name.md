# odoo_stock_inventory_adjustment_name

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_inventory_adjustment_name` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the inventory management process, specifically tracking the naming or labeling of inventory adjustment sessions. It likely acts as a lookup or descriptive entity for stock reconciliation tasks, allowing users to assign human-readable identifiers to inventory count events.

## Description
One row in this table represents a single inventory adjustment name record, acting as a descriptive label for stock-taking activities. It serves as a raw landed copy of the Odoo source table, maintaining the audit trail of who created or modified the record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo user who last updated this record. |
| inventory_adjustment_name | VARCHAR | true | Adjustment label | The descriptive name assigned to the inventory adjustment. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to PII in the `res_users` table.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an `active` boolean flag, which is common in Odoo for soft deletes; assume all records are currently active unless otherwise specified by business logic.
- **Data Precision:** The `VARCHAR` type for `inventory_adjustment_name` does not specify a length; downstream systems should be prepared for variable-length strings.