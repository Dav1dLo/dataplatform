# odoo_stock_orderpoint_snooze

## Source system
This table originates from Odoo ERP, specifically the Inventory (Stock) module. The naming convention `stock_orderpoint_snooze` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the inventory replenishment process by tracking "snooze" configurations for automated reordering rules (orderpoints). It allows users to temporarily suppress replenishment alerts or actions for specific stock items until a designated future date, helping to manage supply chain noise and prevent unnecessary procurement triggers.

## Description
One row in this table represents a single snooze configuration applied to an inventory orderpoint. It serves as a raw landed copy of the Odoo database state, capturing the duration of the snooze and the audit trail of who created or modified the snooze record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the snooze record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| predefined_date | VARCHAR | true | Predefined snooze duration | Likely stores a string identifier for a preset period (e.g., 'next_week'). |
| snoozed_until | DATE | true | Expiration date | The date until which the orderpoint replenishment is suppressed. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp; timezone typically UTC in Odoo. |
| write_date | TIMESTAMP | true | Last modification timestamp | Audit timestamp; timezone typically UTC in Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record updates).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores all timestamps in UTC. Ensure conversions are applied if local time reporting is required.
- **Data Integrity:** As a staging table, this may contain records that have been logically deleted or superseded in the source system if Odoo's `active` flag logic is applied elsewhere; however, no `active` column is present here.
- **PII:** This table contains user IDs (`create_uid`, `write_uid`) which may be linked to employee names in the `res_users` table.
- **Precision:** `predefined_date` is a `VARCHAR` of unknown length; downstream consumers should handle potential truncation if mapping to a fixed-length field.