# odoo_update_product_attribute_value

## Source system
This table originates from Odoo ERP. The naming convention `odoo_update_product_attribute_value` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM tracking tables, likely capturing update logs or synchronization events for product attribute values.

## Functional process 
This table supports the product catalog management process, specifically tracking modifications or synchronization events related to product attribute values. It acts as an audit or staging log for changes made to attribute configurations within the Odoo product module.

## Description
Each row represents a single update or modification event for a specific product attribute value record. It serves as a raw landing copy of Odoo's internal update tracking, capturing the user responsible for the change and the timestamp of the modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.update_product_attribute_value_id_seq`. |
| attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Links to the specific attribute value being updated. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res.users` table. |
| mode | VARCHAR | true | Update mode or operation type | Likely indicates the nature of the update (e.g., 'sync', 'manual'). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by Odoo. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `attribute_value_id` → `product_attribute_value.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** `create_uid` and `write_uid` refer to internal system user IDs; ensure these are joined against the appropriate user dimension table to resolve names.
- **Data Integrity:** As a staging table, this may contain multiple update entries for the same `attribute_value_id`. Use `write_date` to identify the most recent state if performing deduplication.
- **Soft Deletes:** This table does not appear to contain a boolean `active` flag; assume it only tracks update events rather than the current state of the attribute value itself.