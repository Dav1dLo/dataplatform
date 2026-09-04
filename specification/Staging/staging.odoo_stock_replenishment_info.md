# odoo_stock_replenishment_info

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_replenishment_info` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure for stock replenishment rules (often linked to the `stock.warehouse.orderpoint` model).

## Functional process 
This table supports the inventory replenishment and supply chain management process. It tracks metadata or auxiliary information related to stock orderpoints, which are the automated rules that trigger procurement or manufacturing orders when stock levels fall below a defined minimum threshold.

## Description
Each row represents a specific informational record or configuration detail associated with a stock replenishment orderpoint. This is a raw landing table in the staging layer, intended to provide a direct, un-transformed view of the Odoo database state for inventory replenishment configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence value. |
| orderpoint_id | INTEGER | true | Foreign key to the stock orderpoint | Links to the primary replenishment rule definition. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `orderpoint_id` → `stock_warehouse_orderpoint.id`: This column references the core replenishment rule definition in Odoo.
    - `create_uid` → `res_users.id`: Standard Odoo audit field referencing the creator.
    - `write_uid` → `res_users.id`: Standard Odoo audit field referencing the last modifier.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; however, verify against the source application settings if time-zone-sensitive calculations are required.
- **Data Integrity:** As a staging table, this may contain orphaned records if the parent `orderpoint_id` has been deleted in the source system.
- **PII:** No direct PII is present, but `create_uid` and `write_uid` can be used to identify internal employee activity.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag; assume it reflects the current state of the source table as captured during the last ingestion.