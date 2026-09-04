# odoo_stock_track_line

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `stock_track_line` combined with foreign key references like `product_id` and `wizard_id` is characteristic of Odoo's internal inventory tracking and adjustment modules.

## Functional process 
This table supports the inventory tracking and stock adjustment process. It acts as a line-item detail for stock tracking wizards, which are temporary interfaces used in Odoo to record inventory counts, serial number assignments, or stock movements during warehouse operations.

## Description
One row in this table represents a single line item within an inventory tracking or adjustment session. It serves as a raw landed copy of the Odoo `stock.track.line` model, capturing the association between a specific product and a tracking wizard instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.stock_track_line_id_seq`. |
| product_id | INTEGER | true | Foreign key to the product being tracked | References the `product_product` table. |
| wizard_id | INTEGER | true | Foreign key to the parent tracking wizard | References the `stock_track_line_wizard` or similar. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo naming for product references).
    - `wizard_id` → `stock_track_line_wizard.id` (Likely parent container for tracking lines).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail for user actions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As this is a staging table, `product_id` and `wizard_id` may be null if the source record was orphaned or partially initialized during the wizard process.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows present are the current state as captured during the last ingestion.
- **Audit:** `create_uid` and `write_uid` refer to internal Odoo user IDs; ensure these are joined against the `res_users` staging table to resolve actual usernames.