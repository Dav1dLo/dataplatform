# odoo_confirm_stock_sms

## Source system
This table originates from Odoo ERP. The naming convention `odoo_confirm_stock_sms` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables, specifically those related to stock confirmation workflows involving SMS notifications.

## Functional process 
This table supports the inventory management and logistics notification process. It tracks the confirmation events for stock moves or picking operations where an SMS notification is triggered to inform stakeholders (such as warehouse staff or customers) of stock status changes.

## Description
One row in this table represents a single instance of a stock confirmation SMS event triggered within the Odoo system. This is a raw landed staging table, serving as a direct reflection of the Odoo database state for audit and integration purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.confirm_stock_sms_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users` in Odoo. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users` in Odoo. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Odoo default is UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Odoo default is UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are in place if mapping to human-readable names.
- **Timezones:** Timestamps are stored in UTC, consistent with Odoo's internal storage standard.
- **Data Retention:** This table contains standard Odoo audit fields; it does not explicitly indicate a soft-delete flag, so assume all records are active unless an Odoo-specific `active` boolean column is added in future schema versions.
- **Completeness:** This table appears to be a metadata/audit link table; ensure joins to stock move tables are validated for referential integrity.