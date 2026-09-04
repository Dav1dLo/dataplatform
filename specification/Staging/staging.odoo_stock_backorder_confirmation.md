# odoo_stock_backorder_confirmation

## Source system
This table originates from Odoo ERP, specifically the Inventory (Stock) module. The naming convention `odoo_stock_backorder_confirmation` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's ORM-generated tables.

## Functional process 
This table supports the inventory fulfillment process, specifically the "Backorder Confirmation" workflow. It tracks the transient state or configuration settings used when a user decides to create a backorder for a partial stock picking (e.g., when an order cannot be fully fulfilled from current inventory).

## Description
One row in this table represents a single backorder confirmation event or configuration instance triggered during a stock picking operation. It serves as a raw landed copy of the Odoo ORM model `stock.backorder.confirmation`, capturing the metadata and user-defined settings for handling partial deliveries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_backorder_confirmation_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` table. |
| show_transfers | BOOLEAN | true | Flag indicating if transfers should be displayed | Used to toggle UI visibility during the confirmation flow. |
| create_date | TIMESTAMP | true | Record creation timestamp | Odoo default timezone is typically UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Odoo default timezone is typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Retention:** This table represents a transient confirmation state; rows may be ephemeral or purged by Odoo's internal cleanup processes depending on the instance configuration.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names. No direct PII (like emails or names) is present in this specific table.